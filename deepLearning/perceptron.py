# 01.感知器
# 实现布尔运算的分类,https://www.zybuluo.com/hanbingtao/note/433855
from functools import reduce


class Perceptron(object):
    def __init__(self, weights_num, activator):
        self.weights = [0.0 for _ in range(weights_num)]
        self.bias = 0.0
        self.activator = activator

    def __str__(self):
        return 'weights:{}, \nbias:{}'.format(self.weights, self.bias)

    def train(self, input_vec, label, iteration, learn_rate):
        for i in range(iteration):
            self.one_iteration(input_vec, label, learn_rate)

    def one_iteration(self, input_vec, label, learn_rate):
        samples = zip(input_vec, label)
        for (input_vec, label) in samples:
            predict_val = self.predict(input_vec)
            self.update_weights(predict_val, input_vec, label, learn_rate)

    def predict(self, input_vec):
        # x_sum = [x * w for x, w in zip(self.weights, input_vec)]
        x_sum = reduce(lambda x, y: x + y, list(map(lambda x, w: x * w, self.weights, input_vec)), self.bias)
        return self.activator(x_sum)

    def update_weights(self, predict_val, input_vec, label, learn_rate):
        delta = label - predict_val
        self.weights = list(map(lambda x, w: w + learn_rate * x * delta, input_vec, self.weights))
        self.bias = learn_rate * delta + self.bias


def f(x):
    if x > 0:
        return 1
    else:
        return 0


def train_perceptron():
    input_vec = [[1, 1], [0, 0], [0, 1], [1, 0]]
    label = [1, 0, 0, 0]
    p = Perceptron(2, f)
    print(p)
    p.train(input_vec, label, 10, 0.1)
    return p


if __name__ == '__main__':
    fit = train_perceptron()
    print(fit.predict([0, 0]))
    print(fit.predict([0, 1]))
    print(fit.predict([1, 0]))
    print(fit.predict([1, 1]))
