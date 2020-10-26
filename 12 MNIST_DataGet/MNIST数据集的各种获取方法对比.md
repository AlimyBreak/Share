## 方法一:  keras从npz文件中获取

```python
from tensorflow import keras
(x_train, y_train), (x_test, y_test) = keras.datasets.mnist.load_data('D:/DATA/mnist.npz') 
"""
x_train :  (60000,28,28)
y_train : (60000,)
x_test : (10000, 28, 28)
y_test : (10000,)
"""
```



## 方法二:  tensorflow从gz文件中获取

```python
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets('D:/DATA/MNIST_data/gz', one_hot=True)
x_train , y_train   = mnist.train.images , mnist.train.labels
x_test , y_test = mnist.test.images , mnist.test.labels
x_vali , y_vali = mnist.validation.images , mnist.validation.labels
"""
x_train (55000, 784)
y_train (55000, 10)
x_test  (10000, 784)
y_test  (10000, 10)
x_vali  (5000, 784)
y_vali  (5000, 10)
"""
```







