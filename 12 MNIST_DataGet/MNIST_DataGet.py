# -*- coding: utf-8 -*-
"""
Created on Mon Oct 26 15:54:13 2020

@author: YQW

+ 使用TensorFlow中的keras模块，从npz文件中获取数据集

+ 使用TensorFlow中的tensorflow.examples.tutorials.mnist模块，从gz文件中获取数据集



"""


from tensorflow import keras

from tensorflow.examples.tutorials.mnist import input_data


(x_train1, y_train1), (x_test1, y_test1) = keras.datasets.mnist.load_data('D:/DATA/mnist.npz') 


print('-------------keras *.npz ------------ ')
print('x_train1.shape = {}'.format(x_train1.shape))
print('y_train1.shape = {}'.format(y_train1.shape))

print('x_test1.shape = {}'.format(x_test1.shape))
print('y_test1.shape = {}'.format(y_test1.shape))

print('---------------------------------------')

"""
x_train.shape = (60000, 28, 28)
y_train.shape = (60000,)
x_test.shape = (10000, 28, 28)
y_test.shape = (10000,)
"""



mnist = input_data.read_data_sets('D:/DATA/MNIST_data/gz', one_hot=True)
x_train2 , y_train2   = mnist.train.images , mnist.train.labels
x_test2 , y_test2 = mnist.test.images , mnist.test.labels
x_vali2 , y_vali2 = mnist.validation.images , mnist.validation.labels


print('-------------input_data *.gz ------------ ')
print('x_train2.shape = {}'.format(x_train2.shape))
print('y_train2.shape = {}'.format(y_train2.shape))

print('x_test2.shape = {}'.format(x_test2.shape))
print('y_test2.shape = {}'.format(y_test2.shape))

print('x_vali2.shape = {}'.format(x_vali2.shape))
print('y_vali2.shape = {}'.format(y_vali2.shape))
print('---------------------------------------')
"""
x_train.shape = (55000, 784)
y_train.shape = (55000, 10)
x_test.shape = (10000, 784)
y_test.shape = (10000, 10)
x_vali.shape = (5000, 784)
y_vali.shape = (5000, 10)
"""