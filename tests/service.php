<?php

require_once 'vendor/autoload.php';

date_default_timezone_set('Europe/Berlin');

$loop = React\EventLoop\Factory::create();
$context = new React\ZMQ\Context($loop);
$service = $context->getSocket(ZMQ::SOCKET_REP);
$service->bind('tcp://0.0.0.0:5553');

$service->on('error', function ($e) {
    global $loop;
    var_dump($e->getMessage());
    // eventually exit ? this way:
    $loop->stop();
});

function addTimeout($delay, $funcname)
{
    global $loop;
    if(is_midnightpassed()) {
        // sleep at least 6 hours per night
        $delay = 6 * 60 * 60;
    }
    $loop->addTimer($delay, function() use ($funcname) {
        $funcname();
    });
}

// addTimeout(90, 'generate_docs');
// addTimeout(2, 'resend');
// addTimeout(12, 'regenerate');

$service->on('message', function ($msg) {
    global $service, $handler;
    try {
        $request = json_decode($msg);
        // do the work
        print_r($request);
        $response = (object) array('error'=> null);
        $service->send(json_encode($response));
    } catch (Exception $e) {
        $error = new \stdClass;
        $error->message = $e->getMessage();
        $error->file = $e->getFile();
        $error->line = $e->getLine();
        $service->send(json_encode($error));
    }
});

$loop->run();
