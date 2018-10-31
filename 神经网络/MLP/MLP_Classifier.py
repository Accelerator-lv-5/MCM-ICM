from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

# TODO plot confusion matrix, 

import tensorflow as tf

import data

HIDDEN_UNITS = [10, 10] # 《The Loss Surface of Deep Neural Network》
N_CLASSES = 3
BATCH_SIZE = 100
TRAIN_STEPS = 1000
LEARNING_RATE = 0.1
DROPOUT = 0.1

def my_model(features, labels, mode, params):
    """DNN with three hidden layers, and dropout of 0.1 probability.
    Args:
      features: data
      labels: label
      mode: tf.estimator.ModeKeys.PREDICT or tf.estimator.ModeKeys.EVAL or tf.estimator.ModeKeys.TRAIN
      params: dict {'feature_columns': list['feature name1', 'feature name2', ...],
                    'hidden_units': list[hidden_1, hidden_2, ...],
                    'n_classes': class_number}

    Returns:
      tf.estimator.EstimatorSpec
    """
    global LEARNING_RATE, DROPOUT
    # Create three fully connected layers each layer having a dropout
    # probability of DROPOUT.
    train_flag = True if mode==tf.estimator.ModeKeys.TRAIN else False # used for defining network
    net = tf.feature_column.input_layer(features, params['feature_columns'])
    for units in params['hidden_units']:
        net = tf.layers.dense(net, units=units)
        net = tf.layers.batch_normalization(net, training=train_flag) # Reference: http://arxiv.org/abs/1502.03167
        net = tf.nn.relu(net)
        net = tf.layers.dropout(net, rate=DROPOUT, training=train_flag)

    # Compute logits (1 per class).
    logits = tf.layers.dense(net, params['n_classes'], activation=None)

    # Compute predictions.
    predicted_classes = tf.argmax(logits, 1)
    if mode == tf.estimator.ModeKeys.PREDICT:
        predictions = {
            'class_ids': predicted_classes[:, tf.newaxis],
            'probabilities': tf.nn.softmax(logits),
            'logits': logits,
        }
        return tf.estimator.EstimatorSpec(mode, predictions=predictions)

    # Compute loss.
    loss = tf.losses.sparse_softmax_cross_entropy(labels=labels, logits=logits)

    # Compute evaluation metrics.
    accuracy = tf.metrics.accuracy(labels=labels,
                                   predictions=predicted_classes,
                                   name='acc_op')
    percision = tf.metrics.precision(labels=labels,
                                    predictions=predicted_classes,
                                    name='percision_op')
    recall = tf.metrics.recall(labels=labels,
                               predictions=predicted_classes,
                               name='recall_op')
    true_negatives = tf.metrics.true_negatives(labels=labels,
                                               predictions=predicted_classes,
                                               name='tn_op')
    true_positives = tf.metrics.true_positives(labels=labels,
                                               predictions=predicted_classes,
                                               name='tp_op')
    false_negatives = tf.metrics.false_negatives(labels=labels,
                                                 predictions=predicted_classes,
                                                 name='fn_op')
    false_positives = tf.metrics.false_positives(labels=labels,
                                                 predictions=predicted_classes,
                                                 name='fp_op')

    metrics = {'accuracy': accuracy, 
               'percision': percision,
               'recall': recall,
               'true_positives': true_positives,
               'true_negatives': true_negatives,
               'false_negatives': false_negatives,
               'false_positives': false_positives}
    tf.summary.scalar('accuracy', accuracy[1])

    if mode == tf.estimator.ModeKeys.EVAL:
        return tf.estimator.EstimatorSpec(
            mode, loss=loss, eval_metric_ops=metrics)

    # Create training op.
    assert mode == tf.estimator.ModeKeys.TRAIN

    optimizer = tf.train.AdamOptimizer(learning_rate=LEARNING_RATE)
    # optimizer = tf.train.MomentumOptimizer(LEARNING_RATE, momentum, use_nesterov=True) NestrovMomentum
    train_op = optimizer.minimize(loss, global_step=tf.train.get_global_step())
    return tf.estimator.EstimatorSpec(mode, loss=loss, train_op=train_op)


def main(argv):
    global HIDDEN_UNITS, N_CLASSES, BATCH_SIZE, TRAIN_STEPS

    # Fetch the data, train_x train_y test_x test_y are pandas frame
    (train_x, train_y), (test_x, test_y) = data.load_data()

    # Feature columns describe how to use the input.
    my_feature_columns = []
    for key in train_x.keys(): # DataFrame.keys() get the column header, it's feature name
        my_feature_columns.append(tf.feature_column.numeric_column(key=key))

    # Build N_HIDDEN hidden layer DNN with HIDDENT_UNITS respectively.
    classifier = tf.estimator.Estimator(
        model_fn=my_model,
        params={
            'feature_columns': my_feature_columns,
            # global constant HIDDEN_UNITS specify the node in network
            'hidden_units': HIDDEN_UNITS,
            # The model must choose between N_CLASSES classes.
            'n_classes': N_CLASSES,
        })

    # Train the Model.
    classifier.train(
        input_fn=lambda:data.train_input_fn(train_x, train_y, BATCH_SIZE),
        steps=TRAIN_STEPS)

    # Evaluate the model.
    eval_result = classifier.evaluate(
        input_fn=lambda:data.eval_input_fn(test_x, test_y, BATCH_SIZE))

    print('\nTest set accuracy: {}\n'.format(eval_result['accuracy'])) # accuracy
    print('\nTest set accuracy: {}\n'.format(eval_result['accuracy'])) # accuracy
    print('\nTest set accuracy: {}\n'.format(eval_result['accuracy'])) # accuracy
    print('\nTest set accuracy: {}\n'.format(eval_result['accuracy'])) # accuracy
    print('\nTest set accuracy: {}\n'.format(eval_result['accuracy'])) # accuracy

    """
    # Generate predictions from the model
    expected = ['Setosa', 'Versicolor', 'Virginica']
    predict_x = {
        'SepalLength': [5.1, 5.9, 6.9],
        'SepalWidth': [3.3, 3.0, 3.1],
        'PetalLength': [1.7, 4.2, 5.4],
        'PetalWidth': [0.5, 1.5, 2.1],
    }

    predictions = classifier.predict(
        input_fn=lambda:data.eval_input_fn(predict_x,
                                                labels=None,
                                                batch_size=BATCH_SIZE))

    for pred_dict, expec in zip(predictions, expected):
        template = ('\nPrediction is "{}" ({:.1f}%), expected "{}"')

        class_id = pred_dict['class_ids'][0]
        probability = pred_dict['probabilities'][class_id]

        print(template.format(data.SPECIES[class_id],
                              100 * probability, expec))
    """

if __name__ == '__main__':
    tf.logging.set_verbosity(tf.logging.INFO)
    tf.app.run(main)