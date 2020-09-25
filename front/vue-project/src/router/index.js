import Vue from 'vue'
import VueRouter from 'vue-router'
import MyPage from '../views/MyPage.vue'
import Welcome from '../views/welcome.vue'
import EditProfile from '../views/EditProfile.vue'
import RecommendUser from '../views/RecommendUser.vue'
import Hangout from '../views/Hangout.vue'
import MyFollowers from '../views/MyFollowers.vue'
import MyFollowings from '../views/MyFollowings.vue'
import Question from '../views/Question.vue'
import Recommend from '../views/Recommend.vue'
import RegisterProfile from '../views/RegisterProfile.vue'
import RegisterTrend from '../views/RegisterTrend.vue'
import Timeline from '../views/Timeline.vue'
import AddHangout from '../views/AddHangout.vue'
import User from '../views/user.vue'
import UserFollowings from '../views/UserFollowings.vue'
import UserFollowers from '../views/UserFollowers.vue'
import DateTime from '../views/DateTime.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Welcome',
    component: Welcome
  },
  {
    path: '/DateTime',
    name: 'DateTime',
    component: DateTime
  },
  {
    path: '/MyPage',
    name: 'MyPage',
    component: MyPage
  },
  {
    path: '/EditProfile',
    name: 'EditProfile',
    component: EditProfile
  },
  {
    path: '/RecommendUser/:id',
    name: 'RecommendUser',
    component: RecommendUser
  },
  {
    path: '/Hangout/:id',
    name: 'Hangout',
    component: Hangout
  },
  {
    path: '/MyFollowers',
    name: 'MyFollowers',
    component: MyFollowers
  },
  {
    path: '/MyFollowings',
    name: 'MyFollowings',
    component: MyFollowings
  },
  {
    path: '/Question',
    name: 'Question',
    component: Question
  },
  {
    path: '/Recommend/:user_id',
    name: 'Recommend',
    component: Recommend
  },
  {
    path: '/RegisterProfile',
    name: 'RegisterProfile',
    component: RegisterProfile
  },
  {
    path: '/RegisterTrend',
    name: 'RegisterTrend',
    component: RegisterTrend
  },
  {
    path: '/Timeline',
    name: 'Timeline',
    component: Timeline
  },
  {
    path: '/AddHangout',
    name: 'AddHangout',
    component: AddHangout
  },
  {
    path: '/user/:id',
    name: 'user',
    component: User
  },
  {
    path: '/UserFollowings/:user_id',
    name: 'UserFollowings',
    component: UserFollowings
  },
  {
    path: '/UserFollowers/:user_id',
    name: 'UserFollowers',
    component: UserFollowers
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
