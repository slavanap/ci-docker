# AWS ECS post init image.
# Launch with
# docker run --name ecs-agent-roles-init -d --restart=always --privileged --net=host ecs-agent-roles-init

# Launch AWS ECS handler with
# docker run --name ecs-agent -d --restart=always \
#     --volume=/var/run:/var/run --volume=/var/log/ecs/:/log --volume=/var/lib/ecs/data:/data \
#     --volume=/etc/ecs:/etc/ecs --net=host --env-file=/etc/ecs/ecs.config amazon/amazon-ecs-agent

FROM alpine
RUN apk add iptables
CMD /sbin/sysctl -w net.ipv4.conf.all.route_localnet=1 \
 && /sbin/iptables -t nat -A PREROUTING -p tcp -d 169.254.170.2 --dport 80 -j DNAT --to-destination 127.0.0.1:51679 \
 && /sbin/iptables -t nat -A OUTPUT -d 169.254.170.2 -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 51679 \
 && sleep 100000000000000
