#include<stdio.h>
#include<fcntl.h>
#include<unistd.h>
#include<sys/wait.h>
int main(){
	pid_t pid;
	pid = fork();

	if(pid == 0){
		printf("this is child\n");
	}else{
		wait(NULL);
		fork();
		printf("parent\n");
	}
	return 0;
}

