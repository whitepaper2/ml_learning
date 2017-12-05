import itertools
import os

import numpy as np
import tensorflow as tf
from PIL import Image
from cnn import *
from fc import *
from keras.layers import Dense, Dropout, Activation
from keras.models import Sequential, load_model
from keras.optimizers import SGD
from keras.utils import plot_model
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
                y_arr[j] = 1.0
            else:
                y_arr[j] = 0.0
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
    sess.run(tf.global_variables_initializer())
    cost_function = -tf.reduce_sum(y_ * tf.log(tf.clip_by_value(y, 1e-10, 1.0)))
    # cost_function = tf.reduce_mean(-tf.reduce_sum(y_ * tf.log(y), reduction_indices=[1]))
    # cost_function = tf.reduce_sum(tf.square(tf.subtract(y_, y)))
    # cost_function = -tf.reduce_sum(y_*tf.log(y))
    train_step = tf.train.GradientDescentOptimizer(0.001).minimize(cost_function)
    for i in range(1000):
        sess.run(train_step, feed_dict={x: X_train, y_: y_train})
        correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
        accuracy = tf.reduce_mean(tf.cast(correct_prediction, "float"))
        print("accuracy ratio :{}".format(sess.run(accuracy, feed_dict={x: X_test, y_: y_test})))


def fc_test():
    train_and_evaluate()


def keras_test():
    path = './mnist-10000'
    data, label = get_tf_dataset(path)
    x_train, x_test, y_train, y_test = model_selection.train_test_split(data, label, test_size=0.3, random_state=1)
    model = Sequential()
    model.add(Dense(100, activation="sigmoid", input_dim=784))
    model.add(Dropout(0.5))
    model.add(Dense(10, activation="sigmoid"))
    sgd = SGD(lr=0.01, decay=1e-6, momentum=0.9, nesterov=True)
    model.compile(loss='categorical_crossentropy',
                  optimizer=sgd,
                  metrics=['accuracy'])
    model.fit(x_train, y_train,
              epochs=40,
              batch_size=128)
    model.save(filepath="./keras-model")
    plot_model(model, to_file='./keras-model.png')
    print(model.predict(x_test))
    score = model.evaluate(x_test, y_test, batch_size=128)
    print(score)


def load_keras_model():
    path = './mnist-10000'
    data, label = get_tf_dataset(path)
    x_train, x_test, y_train, y_test = model_selection.train_test_split(data, label, test_size=0.3, random_state=1)
    model = load_model("./keras-model")
    predictions = model.predict(x_test)
    print(predictions[0])
    print(y_test[0])


def get_cnn_dataset(path):
    imgs = os.listdir(path)
    num = len(imgs)
    data = np.empty((num, 28, 28), dtype="float32")
    label = np.empty((num, 10), dtype="float32")
    y_arr = np.empty((10,), dtype="float32")
    for i in range(num):
        img = Image.open(path + "/" + imgs[i])
        arr = np.asarray(img, dtype="float32")
        arr_bin = np.where(arr > 0, 1, 0)
        data[i] = arr_bin
        y = int(imgs[i].split(".")[0])
        for j in range(10):
            if j == y:
                y_arr[j] = 1.0
            else:
                y_arr[j] = 0.0
        label[i] = y_arr
    return data, label


def cnn_test():
    path = './mnist-10000'
    data, label = get_cnn_dataset(path)
    x_train, x_test, y_train, y_test = model_selection.train_test_split(data, label, test_size=0.3, random_state=1)
    num = x_train.shape[0]
    for i in range(num):
        c1 = ConvLayer(5, 5, 3, 3, 3, 2, 1, 2, IdentityActivator(), 0.001)
        c1.backward(x_train[i], sensitivity_array, IdentityActivator())
        MaxPoolingLayer(3, 3, 2, 2, 2, 1)
        # flatten扁平化
        # bp神经网络
        network = Network([784, 300, 100, 10])
        network.train(y_train, X_train, 0.01, 1)
        error_ratio = evaluate(network, X_test, y_test)
    print(x_train.shape)

    c1.filters[0].weights = np.array(
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
    MaxPoolingLayer(3, 3, 2, 2, 2, 1)

# 1、使用Keras可视化深度学习流程
# 2、首先安装graphviz.msi，添加环境变量path；然后安装pip install graphviz pydot pydot-ng;最后修改/pydot_ng/__init__.py中的路径
def run():
    import numpy as np
    from keras.models import Sequential
    from keras.layers.core import Dense, Activation
    from keras.optimizers import SGD
    from keras.utils import np_utils
    from keras.utils.vis_utils import plot_model
    # 构建神经网络
    model = Sequential()
    model.add(Dense(4, input_dim=2, kernel_initializer='uniform'))
    model.add(Activation('relu'))
    model.add(Dense(2, kernel_initializer='uniform'))
    model.add(Activation('sigmoid'))
    sgd = SGD(lr=0.05, decay=1e-6, momentum=0.9, nesterov=True)
    model.compile(loss='binary_crossentropy', optimizer=sgd, metrics=['accuracy'])

    # 神经网络可视化
    plot_model(model, to_file='model.png', show_shapes=True)


if __name__ == "__main__":
    # fc_test()
    # sklearn_mlp()
    # tensorflow_test()
    # keras_test()
    # load_keras_model()
    run()
    # cnn_test()
