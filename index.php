<?php

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;

require __DIR__ . '/vendor/autoload.php';

$app = AppFactory::create();
$app->get('/', function ($request, $response, $args) {
    $response->getBody()->write('Hello, World! Salsify.');
    return $response;
});

$app->run();