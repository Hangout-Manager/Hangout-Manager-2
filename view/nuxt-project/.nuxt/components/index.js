export { default as Signin } from '../../components/signin.vue'
export { default as Signup } from '../../components/signup.vue'

export const LazySignin = import('../../components/signin.vue' /* webpackChunkName: "components/signin" */).then(c => c.default || c)
export const LazySignup = import('../../components/signup.vue' /* webpackChunkName: "components/signup" */).then(c => c.default || c)
