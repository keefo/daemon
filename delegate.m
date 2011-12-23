//
//  delegate.m
//  daemon
//
//  Created by liam on 05/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "delegate.h"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


#define DEFAULT_INTERVAL 2
#define DEFAULT_LOGFILE "daemon.txt"


@implementation delegate

-(void)newDaemeon:(id)sender
{
	pid_t   pid, sid;
	
    pid = fork();
	
    if (pid < 0) {
       //exit(EXIT_FAILURE);
    } else if (pid > 0) {
      // exit(EXIT_SUCCESS);
    }
	printf("son thread\n");
    umask(0);
	
    sid = setsid();
    if (sid < 0) {
		printf("son EXIT_FAILURE\n");
		exit(EXIT_FAILURE);
    }
	
	printf("sid=%d\n",sid);
  	if ((chdir("/")) < 0) {
		printf("chdir error\n");
		exit(EXIT_FAILURE);
    }
	
	int i=0;
    while (1) {
        sleep(DEFAULT_INTERVAL);
		FILE *fp=fopen(DEFAULT_LOGFILE,"a");
		if(fp!=NULL)
		{
			printf("tic fp=%d\n",fp);
			fprintf(fp,"%d\n",i++);
			fclose(fp);
		}
		else
		{
			printf("fopen error\n");
			exit(EXIT_FAILURE);
		}
    }
	
}
@end
