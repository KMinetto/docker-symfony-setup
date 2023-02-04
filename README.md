# Docker Symfony Setup

This is a setup to create a symfony application, this contains *NGINX* web server, *PHP 8.1*, *PHPMYADMIN* 

## Pre Requisites

To use it, you need:
* **Docker** and **Docker Compose**
* **Make** for the Makefile

## Installation

```bash
git clone https://github.com/KMinetto/docker-symfony-setup name-of-your-project # Clone the repository
make init
```
Don't forget to give you rights (In development only) :

```bash
# At the root of your project
sudo chown -R $USER ./
```
You can find the project at : [127.0.0.1:8080](http://127.0.0.1:8080)

You can get all commands in the Makefile with this command:

```bash
make help
# or
make
```

## Others
