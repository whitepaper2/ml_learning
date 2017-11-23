# 卷积神经网络：Convolutional Neural Network
import numpy as np


# add zero to input_array
def padding(input_array, zp):
    if zp == 0:
        return input_array
    else:  # 2D\3D
        if input_array.ndim == 2:
            input_width = input_array.shape[1]
            input_height = input_array.shape[0]
            padded_array = np.zeros((input_height + 2 * zp, input_width + 2 * zp))
            padded_array[zp:zp + input_height, zp:zp + input_width] = input_array
            return padded_array
        elif input_array.ndim == 3:
            input_depth = input_array.shape[0]
            input_height = input_array.shape[1]
            input_width = input_array.shape[2]
            padded_array = np.zeros((input_depth, input_height + 2 * zp, input_width + 2 * zp))
            padded_array[:, zp:zp + input_height, zp:zp + input_width] = input_array
            return padded_array


# get conv area
def get_patch(input_array, i, j, filter_width, filter_height, stride):
    start_i = i * stride
    start_j = j * stride
    if input_array.ndim == 2:
        return input_array[start_i:start_i + filter_height, start_j:start_j + filter_width]
    elif input_array.ndim == 3:
        return input_array[:, start_i:start_i + filter_height, start_j:start_j + filter_width]


# calculate conv
def conv(input_array, kernel_array, output_array, stride, bias):
    channel_number = input_array.ndim
    output_height = output_array.shape[0]
    output_width = output_array.shape[1]
    kernel_width = kernel_array.shape[-1]
    kernel_height = kernel_array.shape[-2]
    for i in range(output_height):
        for j in range(output_width):
            output_array[i][j] = (get_patch(input_array, i, j, kernel_width, kernel_height,
                                            stride) * kernel_array).sum() + bias


def element_wise_op(array, op):
    for i in np.nditer(array, op_flags=["readwrite"]):
        i[...] = op(i)


class ConvLayer(object):
    def __init__(self, input_width, input_height, channel_number, filter_width, filter_height, filter_number
                 , zero_padding, stride, activator, learning_rate):
        self.input_width = input_width
        self.input_height = input_height
        self.channel_number = channel_number
        self.filter_width = filter_width
        self.filter_height = filter_height
        self.filter_number = filter_number
        self.zero_padding = zero_padding
        self.stride = stride
        self.activator = activator
        self.learning_rate = learning_rate
        self.output_width = ConvLayer.calculate_output_size(input_width, filter_width, zero_padding, stride)
        self.output_height = ConvLayer.calculate_output_size(input_height, filter_height, zero_padding, stride)
        self.output_array = np.zeros((filter_number, self.output_height, self.output_width))
        self.filters = []
        for i in range(filter_number):
            self.filters.append(Filter(filter_width, filter_height, self.channel_number))

    def calculate_output_size(self, input_size, filter_size, zero_padding, stride):
        return (input_size - filter_size + 2 * zero_padding) / stride + 1

    def forward(self, input_array):
        self.input_array = input_array
        self.padded_input_array = padding(input_array, self.zero_padding)
        for i in range(self.filter_number):
            filter = self.filters[i]
            conv(self.padded_input_array, filter.get_weights(), self.output_array[i], self.stride, self.get_bias())
        element_wise_op(self.output_array, self.activator.forward)

    def expand_sensitivity_map(self, sensitivity_array):
        depth = sensitivity_array.shape[0]
        expend_width = (self.input_width - self.filter_width + 2 * self.zero_padding + 1)
        expend_height = (self.input_height - self.filter_height + 2 * self.zero_padding + 1)
        expend_array = np.zeros((depth, expend_height, expend_width))
        for i in range(expend_height):
            for j in range(expend_width):
                pos_i = self.stride
                pos_j = self.stride
                expend_array[:, pos_i, pos_j] = sensitivity_array[:, i, j]
        return expend_array

    def create_delta_array(self):
        return np.zeros((self.channel_number, self.input_height, self.input_width))

    def bp_sensitivity_map(self, sensitivity_array, activator):
        expended_array = self.expand_sensitivity_map(sensitivity_array)
        expended_width = expended_array.shape[2]
        zp = (self.input_width + self.filter_width - 1 - expended_width) / 2
        padded_array = padding(expended_array, zp)
        self.delta_array = self.create_delta_array()
        for f in range(self.filter_number):
            filter = self.filters[f]
            flipped_weights = np.array(map(lambda i: np.rot90(i, 2), filter.get_weights()))
            delta_array = self.create_delta_array()
            for d in range(delta_array.shape[0]):
                conv(padded_array[f], flipped_weights[d], delta_array[d], 1, 0)
            self.delta_array += delta_array
        derivative_array = np.array(self.input_array)
        element_wise_op(derivative_array, activator.backward)
        self.delta_array *= derivative_array

    def bp_gradient(self, sensitivtity_array):
        expended_array = self.expand_sensitivity_map(sensitivtity_array)
        for f in range(self.filter_number):
            filter = self.filters[f]
            for d in range(filter.weights.shape[0]):
                conv(self.padded_input_array[d], expended_array[f], filter.weights_grad[d], 1, 0)
            filter.bias_grad = expended_array[f].sum()

    def backward(self, input_array, sensitivity_array, activator):
        self.forward(input_array)
        self.bp_sensitivity_map(sensitivity_array, activator)
        self.bp_gradient(sensitivity_array)

    def update(self):
        for f in self.filters:
            f.update(self.learning_rate)


class Filter(object):
    def __init__(self, width, height, depth):
        self.weights = np.random.uniform(-1e-4, 1e-4, (depth, height, width))
        self.bias = 0
        self.weights_grad = np.zeros(self.weights.shape)
        self.bias_grad = 0

    def __repr__(self):
        return "filter weights:\n%s\nbias:\n%s" % repr(self.weights), repr(self.bias)

    def get_weights(self):
        return self.weights

    def get_bias(self):
        return self.bias

    def update(self, learning_rate):
        self.weights -= learning_rate * self.weights_grad
        self.bias -= learning_rate * self.bias_grad


if __name__ == "__main__":
    data = [[1, 2, 3, 4], [5, 6, 7, 8]]
    arr = np.array(data)
    print(arr.ndim, arr.shape[0], arr.shape[1])
