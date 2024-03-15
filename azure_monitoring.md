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

To set up a CPU usage alert on Azure, follow these steps:

1. From the VM Overview -> Monitor -> Create Alert Rule

2. Select condition (e.g. Metric -> CPU Usage)

3. Define the Alert Logic. For example, set the threshold value for the CPU usage that will trigger the alert. For example, you can set it to 90% to receive an alert when the CPU usage exceeds 90%.

4. Assign an action group with sends an email notification to a user when the alert is triggered.

5. Review and create the alert rule.

**Email Alert:**

![alt text](imgs/alert_email.jpg)!

**Alert Fired:**

![alt text](imgs/alert_fired.jpg)!