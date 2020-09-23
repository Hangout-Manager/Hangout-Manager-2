export { default as Post } from '../../components/Post.vue'
export { default as Hangouts } from '../../components/hangouts.vue'
export { default as Signin } from '../../components/signin.vue'
export { default as Signup } from '../../components/signup.vue'

export const LazyPost = import('../../components/Post.vue' /* webpackChunkName: "components/Post" */).then(c => c.default || c)
export const LazyHangouts = import('../../components/hangouts.vue' /* webpackChunkName: "components/hangouts" */).then(c => c.default || c)
export const LazySignin = import('../../components/signin.vue' /* webpackChunkName: "components/signin" */).then(c => c.default || c)
export const LazySignup = import('../../components/signup.vue' /* webpackChunkName: "components/signup" */).then(c => c.default || c)
