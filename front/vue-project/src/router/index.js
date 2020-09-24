import Vue from 'vue'
import VueRouter from 'vue-router'
import MyPage from '../views/MyPage.vue'
import Welcome from '../views/welcome.vue'
import Users from '../views/Users.vue'
import Recommend from '../views/Recommend.vue'
import RecommendUser from '../views/RecommendUser.vue'
import EditProfile from '../views/EditProfile.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Welcome',
    component: Welcome
  },
  {
    path: '/MyPage',
    name: 'MyPage',
    component: MyPage
  },
  {
    path: '/Users',
    name: 'Users',
    component: Users
  },
  {
    path: '/Recommend',
    name: 'Recommend',
    component: Recommend
  },
  {
    path: '/Recommend/:id',
    name: 'RecommendUser',
    component: RecommendUser
  },
  {
    path: '/EditProfile',
    name: 'EditProfile',
    component: EditProfile
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
