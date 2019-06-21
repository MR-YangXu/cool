<template>
  <div>
    <el-dialog
      title=""
      :visible.sync="centerDialogVisible"
      width="85%"
      center>
      <div style="width:100%;height:500px;overflow:hidden;">
       <img :src="imgsrc" alt="" style="width:100%;height:500px;">
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="centerDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="centerDialogVisible = false">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
  export default{
    data(){
      return{
        centerDialogVisible:false,
        imgsrc:''
      }
    },
    watch:{
      centerDialogVisible(val){
        if(!val){
          this.imgsrc = ''
        }
      }
    },
    mounted(){

    },
    methods:{

    }
  }
</script>
