# 使用 Node.js 20 Alpine 作为基础镜像（体积小）
FROM node:20-alpine

# 启用 pnpm（Node 自带 corepack）
RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

# 先复制依赖清单，利用 Docker 缓存
COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile

# 复制整个项目
COPY . .

# 构建项目（根据 README，需要执行 pnpm run build）
RUN pnpm run build

# 暴露 Web UI 端口
EXPOSE 3080

# 启动命令
CMD ["pnpm", "dsh", "web"]
