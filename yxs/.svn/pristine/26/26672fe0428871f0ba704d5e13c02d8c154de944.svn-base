<template>
  <div id="login" v-loading="loading">
    <div id="pic">
      <div style="max-width:200px;width:80%">
         <img src="../../static/img/logo.png" alt="" style="width:100%">
      </div>
    </div>
    <el-form :model="loginInfo" ref="login" :rules="loginRules" style="width:80%;margin:0 auto;">
      <el-form-item prop="admin">
        <i class="iconfont icon-ren"></i>
        <el-select v-model="loginInfo.admin">
          <el-option v-for="(item,index) in optionSelect" :key="index" :value="item.id" :label="item.username"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="password" class="password">
        <i class="iconfont icon-mimasuo"></i>
        <el-input type="password" v-model="loginInfo.password" placeholder="请输入密码"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="login('login')" type="primary">登 录</el-button>
      </el-form-item>
      <el-form-item>
        <p>若您遇到登录问题，请联系医院信息科</p>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default{
  data(){
    return{
      loginInfo:{
        admin:'',
        password:''
      },
      loading:false,
      loginRules:{
        admin:[
          {required:'true',message:'请选择科室',trigger:'blur'},
        ],
        password:[
          {required:'true',message:'请输入密码',trigger:'blur'},
          {pattern:/^[a-zA-Z0-9.]/,message:'只能输入英文、数字、.',trigger:'blur'},
          {min:6,max:20,message:'长度为6~20个字符',trigger:'blur'}
        ]
      },
      optionSelect:[],
    }
  },
  methods:{
    //登录
    login(formName){       
      this.$refs[formName].validate((valid)=>{
        if(valid){
          let Data={
            'id':this.loginInfo.admin,
            'password':this.loginInfo.password
          };
          this.loading=true;
          this.API.post('/api/user/login',Data,{})
          .then(res=>{
            if(res.code==0){
              sessionStorage.setItem('token',res.data.token)
              this.$message({
                type:'success',
                message:res.message,
                duration:1000
              });
              this.$router.push('/index');
            }else{
              this.loginInfo.password='';
              this.$message({
                type:'info',
                message:res.message,
                duration:1000
              });
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
          
        }else{
          return false;
        }
      })
    },
    //获取科室
    getAllUset(){
      this.loading=true;
      this.API.get('/api/user/list',null,{})
      .then(res=>{
        if(res.code==0){
          this.optionSelect=res.data;
        }else{
          this.$message({
            type:'info',
            message:res.message,
            duration:1000
          });
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
    },
  },
  mounted(){
    document.getElementsByClassName('el-input__inner')[0].setAttribute('placeholder','请点击选择科室')
  },
  created(){
    this.getAllUset();
    this.$store.commit('setSickMessage',{});
    this.$store.commit('setCardID','');
    this.$store.commit('historySet',[]);
    this.$store.commit('setHistory',[]);
    this.$store.commit('setTempData',[]);
    this.$store.commit('setRecordId',[]);
    this.$store.commit('setTempData1',[]);
    this.$store.commit('setInfoId',[]);
  }
}
</script>

<style>
  #login{
    height:100%;
  }
  #login .password .el-input{
    width:80%;
  }
  #login .el-select{
    width:80%;
  }
  #login .el-form-item__error{
    left:10%;
  }
  #login #pic{
    height:calc( 100% - 400px);
    min-height: 300px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  #login .el-button{
    width:80%;
    margin-left:20px;
  }
  #login p{
    margin:0;
    padding:0;
    margin-left:20px;
    color:#ccc;
    text-align: center
  }
  #login .iconfont{
    font-size:20px;
  }
</style>