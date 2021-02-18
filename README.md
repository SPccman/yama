# 概述
用于快速构建后端服务拓扑结构

# 目录结构
- sys_services: 框架提供的基础服务
- app_services: 应用实现的服务
- src: 源码
- include: 头文件


# 概念
- Y-SFE: stateful service endpoint
- Y-SLE: stateless service endpoint
- Y-SFR: stateful service router(object message proxy)
- Y-SLR: stateless service router(object message proxy)
- Y-OR: object router(used to allocate object)
- YAMA: yama's brain


# 行为
- Y-SFE 只能被专属的 SFR 观测到。
- Y-SFE 连接所有的 SLE(如果没有专属 SFR) 和 SFR。
- 只能通过 SFR 访问 Y-SFE 
- SFR, SLE(没有专属 SFR) 相互连接(双向还是单向？)


# design

