## Monitoring and Responding to Load/Traffic

When it comes to monitoring and responding to load/traffic, there are different levels of effectiveness. Here is a ranking from worst to best:

1. **No Monitoring**: This is the worst scenario where there is no monitoring in place. It leaves you blind to any issues or potential bottlenecks, making it difficult to respond effectively.

2. **Reactive Monitoring**: In this approach, monitoring is done after an issue or incident occurs. While it allows you to react to problems, it lacks proactive measures to prevent them from happening in the first place.

3. **Threshold-based Monitoring**: This involves setting predefined thresholds for various metrics such as CPU usage, memory utilization, or network traffic. When these thresholds are exceeded, alerts are triggered. While it provides some level of proactive monitoring, it may not capture all potential issues.

4. **Auto Scaling**: This is the most advanced level of monitoring, proactively scaling and optimizing based on demand.

## Setting up a Dashboard

To set up a monitoring dashboard, follow these steps:

1. From the VM Overview, monitor the CPU, Memory, Disk, and Network usage.

2. Pin any metric you want to monitor to the dashboard. Share the dashboard and give it a name.

3. Go to the dashboard on Azure portal.

4. Design your dashboard layout and choose the appropriate visualizations for each metric.

## Combination of Load Testing and Dashboard

By combining load testing and a monitoring dashboard, you can gain valuable insights into your system's performance and make informed decisions. Here's how it can help:

1. Load Testing: Conducting load tests allows you to simulate various traffic scenarios and measure the system's response under different loads. This helps identify performance bottlenecks, scalability issues, and potential areas of improvement.

2. Monitoring Dashboard: The monitoring dashboard provides real-time visibility into the system's performance metrics during load testing. It allows you to monitor key indicators, track resource utilization, and identify any anomalies or deviations from expected behavior.

We can make concurrent requests to the server and monitor the CPU, Memory, Disk, and Network usage in real-time. This helps us understand how the system responds to increased load and identify any performance issues or bottlenecks.

```bash
sudo apt-get install apache2-utils -y

# Send 1000 requests with 100 concurrent requests

ab -n 1000 -c 100 http://172.166.126.211/ | grep "Requests per second"

ab -n 1000 -c 100 http://172.166.126.211/

# Send 10000 requests with 200 concurrent requests

ab -n 10000 -c 200 http://172.166.126.211/
```

Visualizing the CPU usage during load testing:

![alt text](imgs/cpu_testing.jpg)

# Setting up CPU Usage Alert on Azure

1. From the VM Overview -> Monitor -> Create Alert Rule

2. Select condition (e.g. Metric -> CPU Usage)

3. Define the Alert Logic. For example, set the threshold value for the CPU usage that will trigger the alert.

4. Assign an action group which sends an email notification to a user when the alert is triggered.

5. Review and create the alert rule.

**Email Alert:**

![alt text](imgs/alert_email.jpg)!

**Alert Fired:**

![alt text](imgs/alert_fired.jpg)!

# Auto Scaling

## Creating an Azure VM Scale Set

1. Navigate to the Azure portal and "Virtual Machine Scale Set".

2. Select the image to use for the VM Scale Set.

3. In the Networking tab, select the virtual network and subnet for the VM Scale Set.

4. Select Azure load balancer, ensuring it is public. The inbound NAT pool should be set to 50000-50100 for SSH and 80 for HTTP.

5. Define the scaling options, such as the minimum and maximum number of instances and the scale in/out criteria.

6. In the advanced tab, add a simple bash script as user data:
    
```bash
#!/bin/bash

cd tech257-sparta-app/app/

pm2 stop all

pm2 start app.js
```

7. On the Health Probe tab:
- Enable application health monitoring on port 80.
- Enable automatic repairs, so unhealthy instances are deleted and new ones automatically created from the image.
- Set a Grace period of 10 minutes. After 10 minutes, if the instance is still unhealthy, it will be deleted and replaced.

![alt text](imgs/h-i.jpg)

After stopping and restarting a scale set, **reimagine** all instances to ensure the application is running again. Simply restarting an instance means  any dynamic or runtime-specific aspects won't be included.

**Auto-scaling:**

![alt text](imgs/scale-set.jpg)

## Load Balancer and its Importance

A load balancer is a networking device that distributes incoming network traffic across multiple virtual machines. It helps improve the availability and scalability of applications by evenly distributing the workload.

A load balancer ensures that if one vm fails, the traffic is automatically redirected to the remaining vm, minimizing downtime.

Load balancers can act as a single entry point for incoming traffic, providing an additional layer of security by filtering and inspecting requests before forwarding them to the vms.

## Create an unhealthy instance

Stop and start one of the scale sets instances. This will start the instance without restarting the application, resulting in a 502 bad gateway error.

![alt text](imgs/uh-i.jpg)

If the instance is unhealthy for longer than the grace period, the load balancer will automatically delete it and create a new one from the image.

![alt text](imgs/rs-i.jpg)

![alt text](imgs/h-i2.jpg)

## SSH into an instance

In the terminal, run the following command to SSH into an instance:

```bash
ssh -i ~/.ssh/richard-az-key -p 50000 azureuser@<lb-ip-address>
```

Increment the port number by 1 for each instance. it starts at 50000 because the NAT pool is set from 50000.

## Delete a VM Scale Set

We need to delete four elements to delete a VM Scale Set:

- Scale set
- Load balancer
- Public ip address
- Network security group

Deleting them in the above order is recommended.

