# Benchmark execution steps

## Power on

- Start the VM using the Azure web interface or CLI

## Connect

```sh
# via ssh
user@host:~$ ssh -i <vm-key.pem> <vm-user>@<vr-ip>
```

## Cleanup (optional)

```sh
# example: sockshop app
# ONLY if there are previous benchmark results

user@vm:~$ cd ~/workspace/results
user@vm:~/workspace/results$ rm -rf sockshop*
```

## Execute

```sh
# example: sockshop app

# startup sockshop + dmon (make)
user@vm:~$ cd ~/workspace/azure
user@vm:~/workspace/azure$ make start-sockshop

# follow dmon container log (optional)
user@vm:~/workspace/azure$ docker logs -f sockshop_dmon_1

# sync repo
user@vm:~$ cd ~/workspace/data
user@vm:~/workspace/data$ git pull

# startup (nohup)
user@vm:~/workspace/data$ cd benchmark/<benchmark>
user@vm:~/workspace/data/benchmark/<benchmark>$ nohup flow -f <workflow>.yml -o ~/workspace/results -z &
```

## Check progress

```sh
# check for errors (nohup logfile)
user@vm:~/workspace/data/benchmark/<benchmark>$ tail -f nohup.out

# check flow process status
user@vm:~/workspace/data/benchmark/<benchmark>$ ps -ef | grep flow
```

## Reboot

```sh
# ONLY between benchmark executions
user@vm:~$ sudo systemctl reboot
```

## Stop

```sh
# example: sockshop app

# stop (make, docker)
user@vm:~$ cd ~/workspace/azure
user@vm:~/workspace/azure$ make stop-sockshop
user@vm:~/workspace/azure$ make clean-docker
```

## Transfer results

```sh
# from host machine

# example: ~/data = github repo path
user@host:~$ cd ~/data/benchmark/<benchmark>
user@host:~/data/benchmark/<benchmark>$ scp -r -i <vm-key.pem> <vm-user>@<vr-ip>:~/workspace/results .
```

## Power off

- Stop/deallocate the VM using the Azure web interface or CLI
