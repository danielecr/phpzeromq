<?php
require 'vendor/autoload.php';

$context = new \ZMQContext();
$client = $context->getSocket(\ZMQ::SOCKET_REQ);
$client->connect('tcp://localhost:5553');

function sendJob($csv_log_id)
{
    global $client;
    $message = new stdClass();
    $message->cmd = '/execute_this_and_that';
    $message->data = $csv_log_id;

    $jmessage = json_encode($message);

    $client->send($jmessage);
    $jresponse = $client->recv();
    $response = json_decode($jresponse);
    print_r($response);
}

sendJob(8054500); // 7001491
