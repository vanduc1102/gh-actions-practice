const Koa = require("koa");
const Router = require("@koa/router");

require("./scheduler");

const app = new Koa();
const router = new Router();

router.get("/", async (ctx) => {
  ctx.body = {
    status: "success",
    message: "hello, world!",
  };
});

router.get("/health", (ctx) => {
  ctx.body = "Up at " + new Date().toISOString();
});

app.use(async (ctx, next) => {
  await next();
  const rt = ctx.response.get("X-Response-Time");
  console.log(`${ctx.method} ${ctx.url} - ${rt}`);
});

app.use(async (ctx, next) => {
  const start = Date.now();
  await next();
  const ms = Date.now() - start;
  ctx.set("X-Response-Time", `${ms}ms`);
});

app.use(router.routes()).use(router.allowedMethods());

module.exports = app;
