# 向量化实现全连接人工神经网络
import numpy as np
from bp import *


class FullConnectedLayer(object):
    def __init__(self, input_size, output_size, activator):
        self.input_size = input_size
        self.output_size = output_size
        self.activator = activator
        self.W = np.random.uniform(-0.1, 0.1, (output_size, input_size))
        self.b = np.zeros((output_size,))
        self.output = np.zeros((output_size, 1))

    def __str__(self):
        layer = "{}->{}".format(self.input_size, self.output_size)
        print("layer:{},\tW:{},\tb:{},\toutput:{}".format(layer, self.W, self.b, self.output))

    def forward(self, input_array):
        self.input = input_array
        self.output = self.activator.forward(np.dot(self.W, input_array) + self.b)

    def backward(self, delta_array):
        self.delta = self.activator.backward(self.input) * np.dot(
            self.W.T, delta_array)
        self.W_grad = np.dot(delta_array.reshape(len(delta_array), 1), self.input.T.reshape(1, len(self.input)))
        self.b_grad = delta_array

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
        self.update_weight(rate)

    def calc_gradient(self, label):
        delta = self.layers[-1].activator.backward(
            self.layers[-1].output
        ) * (label - self.layers[-1].output)
        for layer in self.layers[::-1]:
            layer.backward(delta)
            delta = layer.delta
        return delta

    def update_weight(self, rate):
        for layer in self.layers:
            layer.update(rate)


def train_and_evaluate():
    path = './mnist-10000'
    data, label = get_dataset(path)
    X_train, X_test, y_train, y_test = model_selection.train_test_split(data, label, test_size=0.3, random_state=1)
    epoch = 0
    network = Network([784, 300, 100, 10])
    min_error = 1
    while True:
        epoch += 1
        network.train(y_train, X_train, 0.01, 1)
        error_ratio = evaluate(network, X_test, y_test)
        print('%s epoch %d finished, error ratio is %f' % (datetime.datetime.now(), epoch, error_ratio))
        if error_ratio < min_error:
            min_error = error_ratio
        if epoch % 10 == 0:
            print('%s after epoch %d, min error ratio is %f' % (datetime.datetime.now(), epoch, min_error))


if __name__ == "__main__":
    train_and_evaluate()
