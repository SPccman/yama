# summary
This is a group of tools witch can be used for establishing server's network topology quickly.

# directories
- sys_services: yama system services
- example_services: example application services
- yterm: yama terminals
- cmake: cmake tool file


# term
- Y-SFE: stateful service endpoint
- Y-SLE: stateless service endpoint
- Y-SFR: stateful service router(object proxy)
- Y-SLR: stateless service router(object proxy)
- Y-OR: object router(used to allocate object)
- YAMA: yama's brain


# behavior
- Y-SFE 只能被专属的 SFR 观测到。
- Y-SFE 连接所有的 SLE(如果没有专属 SFR) 和 SFR。
- 只能通过 SFR 访问 Y-SFE 
- SFR, SLE(没有专属 SFR) 相互连接(双向还是单向？)


# design

