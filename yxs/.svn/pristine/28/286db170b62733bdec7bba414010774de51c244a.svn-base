// 设置默认响应时间
// axios.defaults.timeout = 31 * 1000;
// 设置默认请求头
// axios.defaults.headers = {
//     'Content-Type': 'application/json',
//     'API-User-Token':sessionStorage.getItem('token')
// }
// 请求拦截器
axios.interceptors.request.use(function (config) {
  // 在发送请求之前做些什么
  return config
}, function (error) {
  // 对请求错误做些什么
  return Promise.reject(error)
})
// 响应拦截器
axios.interceptors.response.use(function (response) {
  // 对响应数据做点什么
  return response
}, function (error) {
  // 对响应错误做点什么
  if (error.response.status) {
    switch (error.response.status) {
      case 400:
        error.message = '错误请求'
        break
      case 401:
        error.message = '未授权，请重新登录'
        break
      case 403:
        error.message = '拒绝访问'
        break
      case 404:
        error.message = '请求错误,未找到该资源'
        break
      case 405:
        error.message = '请求方法未允许'
        break
      case 408:
        error.message = '请求超时'
        break
      case 500:
        error.message = '网络出错'
        break
      case 501:
        error.message = '网络未实现'
        break
      case 502:
        error.message = '网络错误'
        break
      case 503:
        error.message = '服务不可用'
        break
      case 504:
        error.message = '网络错误'
        break
      default:
        error.message = '出错啦'
    }
  }
  return Promise.reject(error)
})

const API = {
  get: (url, params = null, header = {'API-User-Token': sessionStorage.getItem('token')}) => {
    return new Promise((resolve, reject) => {
      axios.get(url, {params: params, headers: header})
        .then((res) => {
          resolve(res.data)
        })
        .catch((err) => {
          reject(err)
        })
    })
  },
  post: (url, data = null, header = {'API-User-Token': sessionStorage.getItem('token')}) => {
    return new Promise((resolve, reject) => {
      axios.post(url, data, { headers: header })
        .then((res) => {
          resolve(res.data)
        })
        .catch((err) => {
          reject(err)
        })
    })
  }
}
export default API
