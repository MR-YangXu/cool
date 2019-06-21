<template>
  <div id="app">
     <!-- <keep-alive>
        <router-view/>
     </keep-alive> -->
      <keep-alive>
        <router-view v-if="$route.meta.keepAlive"></router-view>
      </keep-alive>
      <router-view v-if="!$route.meta.keepAlive"></router-view>
  </div>
</template>

<script>
export default {
  name: 'App',
  mounted(){


  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  height: 100%;
  font-size: 14px;
}
.el-button,.el-input,.el-form-item__content,.el-form-item__label,.el-input--mini,.el-radio,.el-checkbox__label,.el-range-editor--mini .el-range-input,.el-range-editor--mini .el-range-separator{
  font-size: 14px;
}
h1{
  font-size: 18px;
  line-height: 60px;
  margin: 0;
  border-bottom: 1px solid #dddddd;
}
h1 span:nth-of-type(1){
    display: inline-block;
    height: 60px;
    width: 60px;
    opacity: 0;
    position: absolute;
    top: 0;
    left: 0;
}
.el-select .el-input__inner{
    cursor:default;
}
h6{
    text-indent: 20px;
    border-left: 6px solid #2e96e6;
    font-size: 16px;
    color: #2e96e6;
    margin: 20px 0;
}
.fontSize16{
  font-size: 14px;
}
.sickWoundStyle{
  margin: 0;
  text-indent: 30px;
}
</style>
