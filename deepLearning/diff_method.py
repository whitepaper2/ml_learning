import itertools
import os

import numpy as np
import tensorflow as tf
from PIL import Image
from fc import *
from sklearn import model_selection
from sklearn import neural_network


def get_mlp_dataset(path):
    imgs = os.listdir(path)
    num = len(imgs)
    data = np.empty((num, 28 * 28), dtype="float32")
    label = np.empty((num,), dtype="int")
    for i in range(num):
        img = Image.open(path + "/" + imgs[i])
        arr = np.asarray(img, dtype="float32")
        arr2one = list(itertools.chain.from_iterable(arr))
        data[i] = arr2one
        y = int(imgs[i].split(".")[0])
        label[i] = y
    return data, label


def get_tf_dataset(path):
    imgs = os.listdir(path)
    num = len(imgs)
    data = np.empty((num, 28 * 28), dtype="float32")
    label = np.empty((num, 10), dtype="int")
    y_arr = np.empty((10,), dtype="int")
    for i in range(num):
        img = Image.open(path + "/" + imgs[i])
        arr = np.asarray(img, dtype="float32")
        arr2one = list(itertools.chain.from_iterable(arr))
        data[i] = arr2one
        y = int(imgs[i].split(".")[0])
        for j in range(10):
            if j == y:
                y_arr[j] = 1
            else:
                y_arr[j] = 0
        label[i] = y_arr
    return data, label


def sklearn_mlp():
    path = './mnist-10000'
    data, label = get_mlp_dataset(path)
    X_train, X_test, y_train, y_test = model_selection.train_test_split(data, label, test_size=0.3, random_state=1)
    network = neural_network.MLPClassifier((300, 100), 'logistic', 'sgd', alpha=0, learning_rate_init=0.01)
    network.fit(X_train, y_train)
    correct_ratio = network.score(X_test, y_test)
    print('correct ratio is %f' % (correct_ratio))


def tensorflow_test():
    path = './mnist-10000'
    data, label = get_tf_dataset(path)
    X_train, X_test, y_train, y_test = model_selection.train_test_split(data, label, test_size=0.3, random_state=1)
    sess = tf.InteractiveSession()
    x = tf.placeholder("float", [None, 784])
    y_ = tf.placeholder("float", shape=[None, 10])
    W = tf.Variable(tf.zeros([784, 10]))
    b = tf.Variable(tf.zeros([10]))
    y = tf.nn.softmax(tf.matmul(x, W) + b)
    sess.run(tf.initialize_all_variables())
    cross_entropy = -tf.reduce_sum(y_ * tf.log(y))
    train_step = tf.train.GradientDescentOptimizer(0.01).minimize(cross_entropy)
    for i in range(200):
        train_step.run(feed_dict={x: X_train, y_: y_train})
    correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, "float"))
    print("error ratio :{}".format(sess.run(accuracy, feed_dict={x: X_test, y_: y_test})))


def fc_test():
    train_and_evaluate()


if __name__ == "__main__":
    # fc_test()
    # sklearn_mlp()
    tensorflow_test()
