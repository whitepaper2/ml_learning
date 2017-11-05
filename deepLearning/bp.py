# bp神经网络
import datetime
import itertools
import os
import re
import shutil
import struct
from functools import reduce
from math import exp

import numpy as np
from PIL import Image
from numpy import *
from sklearn import model_selection


def sigmoid(inx):
    return 1.0 / (1.0 + exp(-inx))


# define node class
class Node(object):
    def __init__(self, layer_index, node_index):
        # layer_index:层的编号
        # node_index:节点编号
        self.layer_index = layer_index
        self.node_index = node_index
        self.downstream = []
        self.upstream = []
        self.output = 0
        self.delta = 0

    def __str__(self):
        node_str = "{}-{}: output:{},delta:{}".format(self.layer_index, self.node_index, self.output, self.delta)
        downstream_str = reduce(lambda x, y: x + " " + y, self.downstream, "")
        upstream_str = reduce(lambda x, y: x + " " + y, self.upstream, "")
        return node_str + "\n\tdownstream:" + downstream_str + "\n\tupstream:" + upstream_str

    def set_output(self, output):
        self.output = output

    def append_downstream_connection(self, conn):
        self.downstream.append(conn)

    def append_upstream_connection(self, conn):
        self.upstream.append(conn)

    def calc_output(self):
        output = reduce(lambda ret, conn: ret + conn.upstream_node.output * conn.weight, self.upstream, 0)
        self.output = sigmoid(output)

    def calc_hidden_layer_delta(self):
        '''
        节点属于隐藏层时，根据式4计算delta
        '''
        downstream_delta = reduce(lambda ret, conn: ret + conn.downstream_node.delta * conn.weight, self.downstream,
                                  0.0)
        self.delta = self.output * (1 - self.output) * downstream_delta

    def calc_output_layer_delta(self, label):
        '''
        节点属于输出层时，根据式3计算delta
        '''
        self.delta = self.output * (1 - self.output) * (label - self.output)


class ConstNode(object):
    def __init__(self, layer_index, node_index):
        self.layer_index = layer_index
        self.node_index = node_index
        self.downstream = []
        self.output = 1
        self.delta = 0

    def __str__(self):
        node_str = '%u-%u: output: 1' % (self.layer_index, self.node_index)
        downstream_str = reduce(lambda ret, conn: ret + '\n\t' + str(conn), self.downstream, '')
        return node_str + '\n\tdownstream:' + downstream_str

    def append_downstream_connection(self, conn):
        self.downstream.append(conn)

    def calc_hidden_layer_delta(self):
        downstream_delta = reduce(lambda ret, conn: ret + conn.downstream_node.delta * conn.weight,
                                  self.downstream, 0.0)
        self.delta = self.output * (1 - self.output) * downstream_delta


class Layer(object):
    def __init__(self, layer_index, node_count):
        self.layer_index = layer_index
        self.nodes = []
        for i in range(node_count):
            self.nodes.append(Node(layer_index, i))
        self.nodes.append(ConstNode(layer_index, node_count))

    def set_output(self, data):
        # 该层为输入层，设置输出值
        for i in range(len(data)):
            self.nodes[i].set_output(data[i])

    def calc_output(self):
        for node in self.nodes[:-1]:
            node.calc_output()

    def dump(self):
        for node in self.nodes:
            print(node)


class Connection(object):
    def __init__(self, upstream_node, downstream_node):
        self.upstream_node = upstream_node
        self.downstream_node = downstream_node
        self.weight = random.uniform(-0.1, 0.1)
        self.gradient = 0.0

    def __str__(self):
        return "{}-{}-->{}-{}:{}".format(self.upstream_node.layer_index, self.upstream_node.node_index,
                                         self.downstream_node.layer_index, self.downstream_node.node_index)

    def calc_gradient(self):
        self.gradient = self.downstream_node.delta * self.upstream_node.output

    def get_gradient(self):
        return self.gradient

    def update_weight(self, rate):
        self.calc_gradient()
        self.weight += rate * self.gradient


class Connections(object):
    def __init__(self):
        self.connections = []

    def add_connection(self, conn):
        self.connections.append(conn)

    def dump(self):
        for conn in self.connections:
            print(conn)


class Network(object):
    def __init__(self, layers):
        self.layers = []
        self.connections = Connections()
        layer_count = len(layers)
        node_count = 0
        for i in range(layer_count):
            self.layers.append(Layer(i, layers[i]))
        for layer in range(layer_count - 1):
            connections = [Connection(upstream_node, downstream_node) for upstream_node in self.layers[layer].nodes for
                           downstream_node in self.layers[layer + 1].nodes[:-1]]
            for conn in connections:
                self.connections.add_connection(conn)
                conn.downstream_node.append_upstream_connection(conn)
                conn.upstream_node.append_downstream_connection(conn)

    def train(self, labels, data_set, rate, iteration):
        for i in range(iteration):
            for d in range(len(data_set)):
                self.train_one_sample(labels[d], data_set[d], rate)

    def train_one_sample(self, label, sample, rate):
        self.predict(sample)
        self.calc_delta(label)
        self.update_weight(rate)

    def calc_delta(self, label):
        output_nodes = self.layers[-1].nodes
        for i in range(len(label)):
            output_nodes[i].calc_output_layer_delta(label[i])
        for layer in self.layers[-2::-1]:
            for node in layer.nodes:
                node.calc_hidden_layer_delta()

    def update_weight(self, rate):
        '''
        内部函数，更新每个连接权重
        '''
        for layer in self.layers[:-1]:
            for node in layer.nodes:
                for conn in node.downstream:
                    conn.update_weight(rate)

    def calc_gradient(self):
        '''
        内部函数，计算每个连接的梯度
        '''
        for layer in self.layers[:-1]:
            for node in layer.nodes:
                for conn in node.downstream:
                    conn.calc_gradient()

    def get_gradient(self, label, sample):
        '''
        获得网络在一个样本下，每个连接上的梯度
        label: 样本标签
        sample: 样本输入
        '''
        self.predict(sample)
        self.calc_delta(label)
        self.calc_gradient()

    def predict(self, sample):
        '''
        根据输入的样本预测输出值
        sample: 数组，样本的特征，也就是网络的输入向量
        '''
        self.layers[0].set_output(sample)
        for i in range(1, len(self.layers)):
            self.layers[i].calc_output()
        return map(lambda node: node.output, self.layers[-1].nodes[:-1])

    def dump(self):
        '''
        打印网络信息
        '''
        for layer in self.layers:
            layer.dump()


def split_mnist(total=1000):
    image_path = 'E:/BaiduNetdiskDownload/mnist/mnist'
    out_path = 'E:/BaiduNetdiskDownload/mnist/mnist-' + str(total)
    files = os.listdir(image_path)
    pattern = re.compile("\.(.+?).jpg$")
    for fi in files:
        ff = re.findall(pattern, fi)
        if int(ff[0]) < total/10:
            oldfile = os.path.join(image_path, fi)
            newfile = os.path.join(out_path, fi)
            shutil.copyfile(oldfile, newfile)
        print(ff)


class Loader(object):
    def __init__(self, path, count):
        self.path = path
        self.count = count

    def get_file_content(self):
        f = open(self.path, "rb")
        content = f.read()
        f.close()
        return content

    def to_int(self, byte):
        return struct.unpack("B", byte)[0]


class ImageLoader(Loader):
    def get_picture(self, content, index):
        start = index * 28 * 28 + 16
        picture = []
        for i in range(28):
            picture.append(i)
            for j in range(28):
                picture[i].append(self.to_int(content[start + i * 28 + j]))
        return picture

    def get_one_sample(self, picture):
        sample = []
        for i in range(28):
            for j in range(28):
                sample.append(picture[i][j])
        return sample

    def load(self):
        content = self.get_file_content()
        data_set = []
        for index in range(self.count):
            data_set.append(self.get_one_sample(self.get_picture(content, index)))
        return data_set


def get_dataset(path):
    imgs = os.listdir(path)
    num = len(imgs)
    data = np.empty((num, 28 * 28), dtype="float32")
    label = np.empty((num, 10), dtype="float32")
    y_arr = np.empty((10,), dtype="float32")
    for i in range(num):
        img = Image.open(path + "/" + imgs[i])
        arr = np.asarray(img, dtype="float32")
        arr2one = list(itertools.chain.from_iterable(arr))
        data[i] = arr2one
        y = int(imgs[i].split(".")[0])
        for j in range(10):
            if j == y:
                y_arr[j] = 0.9
            else:
                y_arr[j] = 0.1
        label[i] = y_arr
    return data, label


def get_result(vec):
    max_value = 0
    max_value_index = 0
    for i in range(len(vec)):
        if vec[i] > max_value:
            max_value = vec[i]
            max_value_index = i
    return max_value_index


def evaluate(network, test_dataset, test_label):
    error = 0
    total = len(test_dataset)
    for i in range(total):
        label = get_result(test_label[i])
        predict = get_result(list(network.predict(test_dataset[i])))
        if label != predict:
            error += 1
    return float(error) / float(total)


def train_and_evaluate():
    path = './mnist-1000'
    data, label = get_dataset(path)
    X_train, X_test, y_train, y_test = model_selection.train_test_split(data, label, test_size=0.3, random_state=1)
    last_error_ratio = 1.0
    epoch = 0
    network = Network([784, 300, 10])
    while True:
        epoch += 1
        network.train(y_train, X_train, 0.3, 1)
        print('%s epoch %d finished' % (datetime.datetime.now(), epoch))
        if epoch % 10 == 0:
            error_ratio = evaluate(network, X_test, y_test)
            print('%s after epoch %d, error ratio is %f' % (datetime.datetime.now(), epoch, error_ratio))
            if error_ratio > last_error_ratio:
                break
            else:
                last_error_ratio = error_ratio


def gradient_check(network, sample_feature, sample_label):
    '''
    梯度检查
    network: 神经网络对象
    sample_feature: 样本的特征
    sample_label: 样本的标签
    '''
    # 计算网络误差
    network_error = lambda vec1, vec2: \
        0.5 * reduce(lambda a, b: a + b,
                     map(lambda v: (v[0] - v[1]) * (v[0] - v[1]),
                         zip(vec1, vec2)))
    # 获取网络在当前样本下每个连接的梯度
    network.get_gradient(sample_feature, sample_label)
    # 对每个权重做梯度检查
    for conn in network.connections.connections:
        # 获取指定连接的梯度
        actual_gradient = conn.get_gradient()
        # 增加一个很小的值，计算网络的误差
        epsilon = 0.0001
        conn.weight += epsilon
        error1 = network_error(network.predict(sample_feature), sample_label)
        # 减去一个很小的值，计算网络的误差
        conn.weight -= 2 * epsilon  # 刚才加过了一次，因此这里需要减去2倍
        error2 = network_error(network.predict(sample_feature), sample_label)
        # 根据式6计算期望的梯度值
        expected_gradient = (error2 - error1) / (2 * epsilon)
        # 打印
        print('expected gradient: \t%f\nactual gradient: \t%f' % (
            expected_gradient, actual_gradient))


if __name__ == '__main__':
    split_mnist(total=10000)
    # train_and_evaluate()
    # print(datetime.datetime.now())
    # print(label)
