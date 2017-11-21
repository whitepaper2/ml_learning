# 01. create variables
import tensorflow as tf
def create_tf_variable():
    weights = tf.Variable(tf.random_normal([784,200], stddev=3.5, name="weights"))
    biases = tf.Variable(tf.zeros([200], name="biases"))
    init = tf.global_variables_initializer()
    with tf.Session() as sess:
        sess.run(init)
        print(sess.run(weights), sess.run(biases))


if __name__ == "__main__":
    pass