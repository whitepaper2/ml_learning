# 向量化实现全连接人工神经网络
import numpy as np


class FullConnectedLayer(object):
    def __init__(self, input_size, output_size, activator):
        self.input_size = input_size
        self.output_size = output_size
        self.activator = activator
        self.W = np.random.uniform(-0.1, 0.1, (output_size, input_size))
        self.b = np.zeros((output_size, 1))
        self.output = np.zeros((output_size, 1))

    def __str__(self):
        layer = "{}->{}".format(self.input_size, self.output_size)
        print("layer:{},\tW:{},\tb:{},\toutput:{}".format(layer, self.W, self.b, self.output))

    def forward(self, input_array):
        self.input = input_array
        self.output = self.activator.forward(np.dot(self.W, input_array) + self.b)

    def backward(self, delta_array):
        pass

    def update(self, learning_rate):
        self.W += self.W_grad * learning_rate
        self.b += self.b_grad * learning_rate


class SigmoidActivator(object):
    def forward(self, weight_input):
        return 1.0 / (1.0 + np.exp(-weight_input))

    def backward(self, output):
        return output * (1 - output)


class Network(object):
    def __init__(self, layers):
        self.layers = []
        for i in range(len(layers) - 1):
            self.layers.append(FullConnectedLayer(layers[i], layers[i + 1], SigmoidActivator()))

    def predict(self, sample):
        output = sample
        for layer in self.layers:
            layer.forward(output)
            output = layer.output
        return output

    def train(self, labels, data_set, rate, epoch):
        for i in range(epoch):
            for j in range(len(data_set)):
                self.train_one_sample(labels[j], data_set[j], rate)

    def train_one_sample(self, label, sample, rate):
        self.predict(sample)
        self.calc_gradient(label)
        self.update_weight(range)

    def calc_gradient(self, label):
        pass

    def update_weight(self, rate):
        pass


if __name__ == "__main__":
    pass
