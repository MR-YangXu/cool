<template>
  <div id="addPerson" v-loading="loading">
    <div id='container'>
       <h1><span @click="linkTo"></span><icon style="padding-left:10px;" class="left" name="back" width="30" height="30"></icon><span class="center">中南大学湘雅医院小智伤口测量-造口科</span></h1>
      <div class="tabShow">
        <p class="mixi">注：在伤口记录前，请输入患者ID，进行患者基本信息录入。</p>
        <el-form label-width="80px" label-position="left">
          <el-form-item label="ID号：">
            <el-input @focus="hideFoot" @blur="showFoot" v-model="cardID"  placeholder="请输入患者ID号"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <el-button @click="queryPatientk">确定</el-button>
    </div>
    <Foot v-show="!isFocus" id="Foot" :index="index" :save="save"></Foot>
  </div>
</template>

<script>
import Foot from '../../components/footer'
export default{
  name:'addPerson',
  components:{Foot},
  data(){
    return{
      save:false,
      loading:false,
      active1:true,
      active2:false,
      index:'1',
      cardID:null,
      isFocus: true
    }
  },
  methods:{
    //查询患者
    queryPatientk(){
      if(this.cardID){
        this.loading=true;
        this.API.get('/api/patient/info/get',{"cardId":this.cardID})
        .then( (res) =>{
          if(res.code==0){
            this.$store.commit('setCardID',this.cardID)
            this.$store.commit('setSickMessage',res.data);
            this.$router.push({
              name:'sickMessage'
            })
          }else{
            this.$message({
              type:'info',
              message:res.message,
              duration:1000
            })
          }
        })
        .catch(err=>{     
          this.$message({
            type:'error',
            message:err.message,
            duration:1000
          });
        })
        .finally(()=>{
          this.loading=false
        })
      }else{
        this.$message({
          type:'info',
          message:'请先输入患者ID',
          duration:1000
        })
      }
      
    },
    //返回登录页
    linkTo(){
      this.$confirm('是否退出登录？','提示',{
        distinguishCancelAndClose: true,
        showClose:false,
        confirmButtonText: '确定',
        cancelButtonText: '返回',
        type: 'warning',
        center: true
      })
      .then(()=>{
        let Data={};
        this.loading=true;
        this.API.post('/api/user/logout',Data)
        .then(res=>{
          if(res.code==0){
            this.$message({
              type:'success',
              message:res.message,
              duration:1000
            });
            sessionStorage.removeItem('token');
            this.$router.push('/');
          }else{
            this.$message({
              type:'info',
              message:res.message,
              duration:1000
            })
          }
        })
        .catch(err=>{
          this.$message({
            type:'error',
            message:err.message,
            duration:1000
          });
        })
        .finally(()=>{
          this.loading=false;
        })
      })
    },
    hideFoot(){
      this.isFocus = true
    },
    showFoot(){
      this.isFocus = false
    },
  },
  mounted(){
  }
}
</script>

<style>
#addPerson .el-input input{
  border: 0;
}
#addPerson{
  overflow: hidden;
  height: 100%;
}
#addPerson #container{
  height: calc(100% - 80px);
}
#addPerson .tabShow{
  margin-top: 50px;
  padding-bottom: 10px;
  padding:0 30px;
}
#addPerson .el-input{
  width:100%;
  border:0px;
  outline:none;
}
#addPerson .el-button{
  color: #ffffff;
  padding: 15px 15%;
  border-radius: 20px;
  margin-top: 100px;
  text-align: center;
  background-color: #2e96e6;
}
#addPerson h1{
  display: flex;
  align-items: center;
}
#addPerson .left{
  justify-content:flex-start;
}
#addPerson .center{
  width:100%;
}
#addPerson .mixi{
  color:#58aae9;
  text-align: left;
}
#addPerson .el-form{
  padding-top: 80px;
  border-bottom: 1px solid #ccc;
}
#addPerson .el-form-item{
  margin-bottom: 0px;
}
#addPerson .el-form-item__label,.el-form-item__content{
  font-size: 14px;
}
</style>
