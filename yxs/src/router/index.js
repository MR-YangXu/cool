// import Vue from 'vue'
// import Router from 'vue-router'
import login from '@/views/login'
const sickMessage = () => import('@/views/sickPersonLogin/sickMessage')
const sickWound = () => import('@/views/sickPersonLogin/sickWound')
const chulifangshi = () => import('@/views/woundRecode/chulifangshi')
const searchArchive = () => import('@/views/synArchive/searchArchive')
const change = () => import('@/views/healingChange/change')
const addPerson = () => import('@/views/sickPersonLogin/addPerson')

// import addPerson from '@/views/sickPersonLogin/addPerson'
// import sickMessage from '@/views/sickPersonLogin/sickMessage'
// import sickWound from '@/views/sickPersonLogin/sickWound'
// import chulifangshi from '@/views/woundRecode/chulifangshi'
// import searchArchive from '@/views/synArchive/searchArchive'
// import change from '@/views/healingChange/change'
// Vue.use(Router)
const router = new VueRouter({
  routes: [
    {
      path: '/',
      name: 'login',
      component: login,
      meta: {
        keepAlive: false // 需要被缓存
      }
    },
    {
      path: '/index',
      name: 'addPerson',
      component: addPerson,
      meta: {
        keepAlive: false // 需要被缓存
      }
    }, {
      path: '/sickMessage',
      name: 'sickMessage',
      component: sickMessage,
      meta: {
        keepAlive: false // 需要被缓存
      }
    }, {
      path: '/sickWound',
      name: 'sickWound',
      component: sickWound,
      meta: {
        keepAlive: false // 需要被缓存
      }
    },
    {
      path: '/chulifangshi',
      name: 'chulifangshi',
      component: chulifangshi,
      meta: {
        keepAlive: false // 需要被缓存
      }
    }, {
      path: '/searchArchive',
      name: 'searchArchive',
      component: searchArchive,
      meta: {
        keepAlive: true // 需要被缓存
      }
    }, {
      path: '/change',
      name: 'change',
      component: change,
      meta: {
        keepAlive: false // 需要被缓存
      }
    }
  ]
})

// router.beforeEach((to, from, next) => {
//   if (sessionStorage.getItem('token')) {
//     next()
//   } else {
//     if (to.path == '/') {
//       next()
//     } else {
//       next('/')
//     }
//   }
// })

export default router
