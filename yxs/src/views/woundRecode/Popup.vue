<template>
  <div v-if="isshow">
    <div class="cover"></div>
    <div class="popuup">
      <div class="popuup-item" @click="isShowIMG = true">
        <span>查看图片</span>
      </div>
      <div class="popuup-item" @click="handleRest">
        <span>重新拍摄</span>
      </div>
      <div class="popuup-item" @click="isshow = false">
        <span>取消</span>
      </div>
    </div>
    <img :src="imgsrc" alt="" class="img-view" v-if="isShowIMG" @click="isShowIMG = false">
  </div>
</template>

<script>
  export default{
    data(){
      return{
         imgsrc:'',
         isshow:false,
         isShowIMG:false,
         val:null,
      }
    },
    methods:{
      handleRest(){
        this.$emit('popover',this.val)
      }
    }
  }
</script>

<style scoped>
.popuup{
  background:#FFFFFF;
  position:fixed;
  bottom:0;
  left:0;
  right:0;
  z-index:1000;
  display:flex;
  flex-direction:column;
}
.popuup-item{
  vertical-align: middle;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  height: 80px;
}
span{
  line-height: 80px;
  font-size: 24px;
}
.img-view{
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 2000;
  width: 100%;
  height: 100%;
}
.cover{
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  width: 100%;
  background: #3B3B3B;
  z-index: 999;
  bottom:0;
  opacity: 0.5
}
</style>
