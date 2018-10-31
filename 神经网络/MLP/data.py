# coding:utf-8
import pandas as pd
import tensorflow as tf

import pickle

TRAIN_URL = "http://download.tensorflow.org/data/iris_training.csv" # train data path
TEST_URL = "http://download.tensorflow.org/data/iris_test.csv" # test data path


def load_data(y_name='Species'):
    """Returns the dataset as (train_x, train_y), (test_x, test_y).
    Args:
      y_name: str, class name in pandas frame header/excel column header

    Returns:
      train_x: pandas frame, train data
      train_y: pandas frame, train label
      test_x: pandas frame, test data
      test_y: pandas frame, test label
    """
    # train data path, test data path
    global TRAIN_URL, TEST_URL

    train_f = open(TRAIN_URL, 'rb')
    train = pickle.load(train_f)
    train_x, train_y = train, train.pop(y_name)

    test_f = open(TRAIN_URL, 'rb')
    test = pickle.load(test_f)
    test_x, test_y = test, test.pop(y_name)

    train_f.close()
    test_f.close()

    return (train_x, train_y), (test_x, test_y)


def train_input_fn(features, labels, batch_size):
    """An input function for training
    Args:
      features: pandas.core.DataFrame, train data
      labels: pandas.core.DataFrame, train label
      batch_size: int, batch size

    Returns:
      dataset: tf.data.Dataset
    """
    # Convert the inputs to a Dataset.
    dataset = tf.data.Dataset.from_tensor_slices((dict(features), labels))

    # Shuffle, repeat, and batch the examples.
    dataset = dataset.shuffle(1000).repeat().batch(batch_size)

    # Return the dataset.
    return dataset


def eval_input_fn(features, labels, batch_size):
    """An input function for evaluation or prediction
    Args:
      features: pandas.core.DataFrame, eval data
      labels: pandas.core.DataFrame, eval label
      batch_size: int, batch size

    Returns:
      dataset: tf.data.Dataset
    """
    features=dict(features)
    if labels is None:
        # No labels, use only features.
        inputs = features
    else:
        inputs = (features, labels)

    # Convert the inputs to a Dataset.
    dataset = tf.data.Dataset.from_tensor_slices(inputs)

    # Batch the examples
    assert batch_size is not None, "batch_size must not be None"
    dataset = dataset.batch(batch_size)

    # Return the dataset.
    return dataset