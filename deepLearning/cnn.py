# 卷积神经网络：Convolutional Neural Network
import numpy as np
from activators import IdentityActivator


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
        self.output_height = ConvLayer.calculate_output_size(input_height, filter_height, zero_padding,
                                                             stride)
        self.output_array = np.zeros((filter_number, self.output_height, self.output_width))
        self.filters = []
        for i in range(filter_number):
            self.filters.append(Filter(filter_width, filter_height, self.channel_number))

    @staticmethod
    def calculate_output_size(input_size, filter_size, zero_padding, stride):
        return (input_size - filter_size + 2 * zero_padding) // stride + 1

    def forward(self, input_array):
        self.input_array = input_array
        self.padded_input_array = padding(input_array, self.zero_padding)
        for i in range(self.filter_number):
            filter = self.filters[i]
            conv(self.padded_input_array, filter.get_weights(), self.output_array[i], self.stride, filter.get_bias())
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


def get_max_index(arr):
    max_i = 0
    max_j = 0
    max_value = arr[0, 0]
    for i in range(arr.shape[0]):
        for j in range(arr.shape[1]):
            if max_value < arr[i, j]:
                max_value = arr[i, j]
                max_i = i
                max_j = j
    return max_i, max_j


class MaxPoolingLayer(object):
    def __init__(self, input_width, input_height, channel_number, filter_width, filter_height, stride):
        self.input_width = input_width
        self.input_height = input_height
        self.channel_number = channel_number
        self.filter_width = filter_width
        self.filter_height = filter_height
        self.stride = stride
        self.output_width = (input_width - filter_width) // self.stride + 1
        self.output_height = (input_height - filter_height) // self.stride + 1
        self.output_array = np.zeros((channel_number, self.output_height, self.output_width))

    def forward(self, input_array):
        for d in range(self.channel_number):
            for i in range(self.output_height):
                for j in range(self.output_width):
                    self.output_array[d, i, j] = (get_patch(input_array[d], i, j, self.filter_width, self.filter_height,
                                                            self.stride).max())

    def backward(self, input_array, sensitivity_map):
        self.delta_array = np.zeros(input_array.shape)
        for d in range(self.channel_number):
            for i in range(self.output_height):
                for j in range(self.output_width):
                    patch_array = get_patch(input_array[d], i, j, self.filter_width, self.filter_height, self.stride)
                    k, l = get_max_index(patch_array)
                    self.delta_array[d, i * self.stride + k, j * self.stride + l] = sensitivity_map[d, i, j]


def init_test():
    a = np.array(
        [[[0, 1, 1, 0, 2],
          [2, 2, 2, 2, 1],
          [1, 0, 0, 2, 0],
          [0, 1, 1, 0, 0],
          [1, 2, 0, 0, 2]],
         [[1, 0, 2, 2, 0],
          [0, 0, 0, 2, 0],
          [1, 2, 1, 2, 1],
          [1, 0, 0, 0, 0],
          [1, 2, 1, 1, 1]],
         [[2, 1, 2, 0, 0],
          [1, 0, 0, 1, 0],
          [0, 2, 1, 0, 1],
          [0, 1, 2, 2, 2],
          [2, 1, 0, 0, 1]],
         [[2, 1, 2, 0, 0],
          [1, 0, 0, 1, 0],
          [0, 2, 1, 0, 1],
          [0, 1, 2, 2, 2],
          [2, 1, 0, 0, 1]]])
    b = np.array(
        [[[0, 1, 1],
          [2, 2, 2],
          [1, 0, 0]],
         [[1, 0, 2],
          [0, 0, 0],
          [1, 2, 1]]])
    cl = ConvLayer(5, 5, 3, 3, 3, 2, 1, 2, IdentityActivator(), 0.001)
    cl.filters[0].weights = np.array(
        [[[-1, 1, 0],
          [0, 1, 0],
          [0, 1, 1]],
         [[-1, -1, 0],
          [0, 0, 0],
          [0, -1, 0]],
         [[0, 0, -1],
          [0, 1, 0],
          [1, -1, -1]]], dtype=np.float64)
    cl.filters[0].bias = 1
    cl.filters[1].weights = np.array(
        [[[1, 1, -1],
          [-1, -1, 1],
          [0, -1, 1]],
         [[0, 1, 0],
          [-1, 0, -1],
          [-1, 1, 0]],
         [[-1, 0, 0],
          [-1, 0, 1],
          [-1, 0, 0]]], dtype=np.float64)
    return a, b, cl


def test():
    a, b, cl = init_test()
    cl.forward(a)
    print(cl.output_array)
    out = cl.output_array
    print(out.shape)
    mpl = MaxPoolingLayer(3, 3, 2, 2, 2, 1)
    mpl.forward(out)
    print(mpl.output_array)


def test_bp():
    a, b, cl = init_test()
    cl.backward(a, b, IdentityActivator())
    cl.update()
    print
    cl.filters[0]
    print
    cl.filters[1]



if __name__ == "__main__":
    # a, b, c1 = init_test()
    # print(a, b, c1)
    test()
    # test_bp()
