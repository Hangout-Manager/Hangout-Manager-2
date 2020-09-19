import Vue from 'vue'
import Router from 'vue-router'
import { interopDefault } from './utils'
import scrollBehavior from './router.scrollBehavior.js'

const _42d71b37 = () => interopDefault(import('../pages/MyPage.vue' /* webpackChunkName: "pages/MyPage" */))
const _7ed23c4c = () => interopDefault(import('../pages/RegisterProfile.vue' /* webpackChunkName: "pages/RegisterProfile" */))
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
    path: "/MyPage",
    component: _42d71b37,
    name: "MyPage"
  }, {
    path: "/RegisterProfile",
    component: _7ed23c4c,
    name: "RegisterProfile"
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
