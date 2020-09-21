import Vue from 'vue'
import Router from 'vue-router'
import { interopDefault } from './utils'
import scrollBehavior from './router.scrollBehavior.js'

const _af18ebda = () => interopDefault(import('../pages/EditProfile.vue' /* webpackChunkName: "pages/EditProfile" */))
const _3f1a1c7a = () => interopDefault(import('../pages/MyPage/index.vue' /* webpackChunkName: "pages/MyPage/index" */))
const _7ed23c4c = () => interopDefault(import('../pages/RegisterProfile.vue' /* webpackChunkName: "pages/RegisterProfile" */))
const _29821be4 = () => interopDefault(import('../pages/RegisterTrend.vue' /* webpackChunkName: "pages/RegisterTrend" */))
const _4ea4145c = () => interopDefault(import('../pages/Users.vue' /* webpackChunkName: "pages/Users" */))
const _1540e2e0 = () => interopDefault(import('../pages/MyPage/Followers/index.vue' /* webpackChunkName: "pages/MyPage/Followers/index" */))
const _1023fcad = () => interopDefault(import('../pages/MyPage/Followings/index.vue' /* webpackChunkName: "pages/MyPage/Followings/index" */))
const _2144e09c = () => interopDefault(import('../pages/user/_id.vue' /* webpackChunkName: "pages/user/_id" */))
const _d1786e9e = () => interopDefault(import('../pages/user/_user_id/Followers/index.vue' /* webpackChunkName: "pages/user/_user_id/Followers/index" */))
const _63045e08 = () => interopDefault(import('../pages/user/_user_id/Followings/index.vue' /* webpackChunkName: "pages/user/_user_id/Followings/index" */))
const _dc6fcb74 = () => interopDefault(import('../pages/index.vue' /* webpackChunkName: "pages/index" */))

// TODO: remove in Nuxt 3
const emptyFn = () => {}
const originalPush = Router.prototype.push
Router.prototype.push = function push (location, onComplete = emptyFn, onAbort) {
  return originalPush.call(this, location, onComplete, onAbort)
}

Vue.use(Router)

export const routerOptions = {
  mode: 'history',
  base: decodeURI('/'),
  linkActiveClass: 'nuxt-link-active',
  linkExactActiveClass: 'nuxt-link-exact-active',
  scrollBehavior,

  routes: [{
    path: "/EditProfile",
    component: _af18ebda,
    name: "EditProfile"
  }, {
    path: "/MyPage",
    component: _3f1a1c7a,
    name: "MyPage"
  }, {
    path: "/RegisterProfile",
    component: _7ed23c4c,
    name: "RegisterProfile"
  }, {
    path: "/RegisterTrend",
    component: _29821be4,
    name: "RegisterTrend"
  }, {
    path: "/Users",
    component: _4ea4145c,
    name: "Users"
  }, {
    path: "/MyPage/Followers",
    component: _1540e2e0,
    name: "MyPage-Followers"
  }, {
    path: "/MyPage/Followings",
    component: _1023fcad,
    name: "MyPage-Followings"
  }, {
    path: "/user/:id?",
    component: _2144e09c,
    name: "user-id"
  }, {
    path: "/user/:user_id?/Followers",
    component: _d1786e9e,
    name: "user-user_id-Followers"
  }, {
    path: "/user/:user_id?/Followings",
    component: _63045e08,
    name: "user-user_id-Followings"
  }, {
    path: "/",
    component: _dc6fcb74,
    name: "index"
  }],

  fallback: false
}

export function createRouter () {
  return new Router(routerOptions)
}
