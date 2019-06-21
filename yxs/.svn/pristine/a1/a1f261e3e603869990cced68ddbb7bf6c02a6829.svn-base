<template>
  <div id="searchArchive" v-loading="loading">
    <h1><span @click="backTo"></span><span v-if="search[0]"></span><icon v-if="search[0]==false" name="back" width="30" height="30"></icon>{{title}}<span>&nbsp;</span></h1>
    <div class="tab">
      <p v-if="tootip" style="padding:0 20px 10px;text-align:left;color:#ccc;margin:0;border-bottom:1px solid #ccc;">如需在PC端应用图片与信息，请在浏览器中输入下列地址进行查看： http://111.8.62.110:8380/</p>
      <div v-if="!tootip" style="display:flex;border-bottom:2px solid #409EFF">
        <el-select v-model="Years" style="width:100px">
          <el-option v-for="(item,index) in yearsList" :key="index" :label="item.label" :value="item.value"></el-option>
        </el-select>
        <div style="width:calc(100% - 110px);display:flex;overflow-x:auto;align-items:center;padding-right:10px;">
          <el-button size="mini" class="monthButton" @click="  chooseMonth(item,index)" v-for="(item,index) in Months" :key="index" >{{item.label}}</el-button>
        </div>
      </div>
      <div v-if="search[0]" class="tabShow">
         <el-row  class="searchInput">
          <el-col :span="22">
             <el-input @focus="hideFoot" @blur="showFoot"  class="dd" placeholder="请输入患者名字或ID" v-model="keyword" @change="querySick('hzlb',woundType,conversion,keyword)"></el-input>
          </el-col>
         </el-row>
        <div class="sorting">
          <el-row v-for="(item ,index) in searchList" :key="index">
            <el-col :span='22' :offset="1">
              <div class="flexRow" @click="clickSearch(item.type,item.value)">
                <span>{{item.value}}</span><icon name="right" width="20" height="20"></icon>
              </div>
            </el-col>
          </el-row>
        </div>
      </div>
      <div v-if="search[1]">
        <el-row class="searchInput">
          <el-col :span="22" class="dd">
            <el-input  @focus="hideFoot" @blur="showFoot" placeholder="请输入患者名字或ID" v-model="keyword" @change="searchName(searchType,woundType,conversion,keyword,leavel,typeOther)"></el-input>
          </el-col>
         </el-row>
         <div v-if="search[3]" style="margin-top:20px">
           <el-button v-for="(item,index) in zgyl" class="allButton" :key="index" size="mini" @click="zgylSearch(item.type,woundType,index,keyword)">{{item.value}}</el-button>
         </div>
         <div class="listDiv">
           <el-row>
             <el-col :span="22" :offset="1">
               <el-button v-if="item.value" style="margin:2px 4px;" size="mini" class="allbutton" @click="viewSK(item,index)" v-for="(item,index) in buttonList" :key="index" >{{item.value}}</el-button>
               <el-button v-if="!item.value" style="margin:2px 4px;" size="mini" class="allbutton" @click="viewSK(item,index)" v-for="(item,index) in buttonList" :key="index" >{{item.name}}</el-button>
             </el-col>
           </el-row>
           <template v-for="(val,key,index) in allSickList" v-if="val.length>0">
            <p class="listP" :key="index">{{key}}</p>
            <div :key="key">
              <el-row>
                <el-col :span="20" :offset="2" style="text-align:left" v-for="(item,index) in val" :key="index">
                  <p @click="lookInfo(item.id,item.name,item.cardId)"> {{item.name}}     ID:{{item.cardId}}</p>
                </el-col>
              </el-row>
            </div>
           </template>
         </div>
      </div>
      <div v-if="search[2]">
        <el-row class="searchInput">
          <el-col :span="22" class="dd">
            <el-input  @focus="hideFoot" @blur="showFoot" placeholder="请输入患者名字或ID" v-model="keyword" @change="searchName(searchType,woundType,conversion,keyword,leaval,typeOther)"></el-input>
          </el-col>
         </el-row>
        <el-row v-show="skShow">
          <el-col :span="22" :offset="1" v-for="(item,index) in allWoundType" :key="index">
            <div class="flexRow" @click="one(item.id,item.name)">
              <span>{{item.name}}</span><icon name="right" width="20" height="20"></icon>
            </div>
          </el-col>
        </el-row>
        <el-row v-show="!skShow">
          <el-col class="hang" :span="22" :offset="1" v-for="(item,index) in allWoundType[num].children" :key="index">
            <p @click="searchWoungType(item.id,item.name,item)" style="margin:0">{{item.name}}</p>
          </el-col>
        </el-row>
      </div>
    </div>
    <Foot v-show="!isFocus" id="Foot" :index="index" :save="save"></Foot>
  </div>
</template>

<script>
import Foot from '../../components/footer'
export default {
  name:'searchArchive',
  components:{Foot},
  data(){
    return{
      isFocus: false,
      save:false,
      leavel:'',
      typeOther:'',
      tootip:true,
      Years:'',
      yearsList:[],
      months:'',
      Months:[
        {
          value:'01',
          label:'1月'
        },
        {
          value:'02',
          label:'2月'
        },
        {
          value:'03',
          label:'3月'
        },
        {
          value:'04',
          label:'4月'
        },
        {
          value:'05',
          label:'5月'
        },
        {
          value:'06',
          label:'6月'
        },
        {
          value:'07',
          label:'7月'
        },
        {
          value:'08',
          label:'8月'
        },
        {
          value:'09',
          label:'9月'
        },
        {
          value:'10',
          label:'10月'
        },
        {
          value:'11',
          label:'11月'
        },
        {
          value:'12',
          label:'12月'
        },
      ],
      buttonList:[],
      skShow:true,
      num:0,
      allWoundType:[],
      loading:false,
      index:'4',
      searchList:[],
      search:[true,false,false,false],
      title:'同步归档与检索',
      allSickList:{},
      searchType:'',
      zgyl:[
        {
          type:'zgyl',
          value:'愈合'
        },{
          type:'zgyl',
          value:'好转'
        },{
          type:'zgyl',
          value:'无变化'
        },{
          type:'zgyl',
          value:'恶化'
        },
      ],
      keyword:'',
      woundType:null,
      conversion:null,

    }
  },
  methods:{
    // 选择月份
    chooseMonth(item,index){
      this.months=item.value;
      let len=document.getElementsByClassName('monthButton').length;
      for(let i=0;i<len;i++){
        document.getElementsByClassName('monthButton')[i].style.backgroundColor='rgb(166,166,166)'
      };
      document.getElementsByClassName('monthButton')[index].style.backgroundColor='#409EFF';
      this.searchAPI(this.searchType,'','',this.keyword,'','',this.Years+'-'+item.value)
    },
    viewSK(item,index){
      let len=document.getElementsByClassName('allbutton').length;
      for(let i=0;i<len;i++){
        document.getElementsByClassName('allbutton')[i].style.backgroundColor='rgb(166,166,166)'
      }
      document.getElementsByClassName('allbutton')[index].style.backgroundColor='#409EFF';
      if(item.value){
        this.searchAPI(this.searchType,item.type,'',this.keyword,item.id,'','');
        this.leavel=item.id;
        this.typeOther='';
      }else{
        this.searchAPI(this.searchType,item.parentId,'',this.keyword,'',item.id,'');
        this.leavel='';
        this.typeOther=item.parentId;
      }
    },
    //聚焦隐藏底部栏
    hideFoot(){
      this.isFocus = true
    },
    //失焦显示底部栏
    showFoot(){
      this.isFocus = false
    },
    // 患者查询
    querySick(type,woundType,conversion,keyword1){
      if(keyword1){
        this.$set(this.search,0,false);
        this.$set(this.search,1,true);
        this.keyword='';
         this.title='患者列表';
        this.searchAPI(type,woundType,conversion,keyword1);
      }
    },
    //名字或者卡号搜索
    searchName(type,woundType,conversion,keyword,leavel,other){
      if(this.months){
        this.searchAPI(type,woundType,conversion,keyword,leavel,other,this.Years+'-'+this.months)
      }else{
        this.searchAPI(type,woundType,conversion,keyword,leavel,other)
      }
    },
    //获取检索条件列表
    getAllSearch(){
      this.loading=true;
      this.API.get('/api/search/listType')
      .then(res =>{
        if(res.code==0){
          this.searchList=res.data;
        }else{
          this.$message({
            type:'info',
            message:'获取检索条件列表：'+res.message,
            duration:1000
          })
        }

      })
      .catch((err)=>{
        this.$message({
          type:'error',
          message:'获取检索条件列表：'+err.message,
          duration:1000
        })
      })
      .finally(()=>{
        this.loading=false;
      })
    },
    //点击检索
    clickSearch(type,value){
      this.searchType=type;
      if(type=='sklx'){
        this.$set(this.search,2,true);
        this.$set(this.search,0,false);
        this.title=value;
      }else if(type=='zgyl'){
        this.searchAPI(type);
        this.title=value+'患者列表';
        this.$set(this.search,0,false);
        this.$set(this.search,1,true);
        this.$set(this.search,3,true);
      }else if(type=='sjrq'){
        this.tootip=false;
        this.searchAPI(type);
        if(value=="患者列表"){
          this.title=value;
        }else{
          this.title=value+'患者列表';
        }
        this.$set(this.search,0,false);
        this.$set(this.search,1,true);
      }else{
        this.searchAPI(type);
        if(value=="患者列表"){
          this.title=value;
        }else{
          this.title=value+'患者列表';
        }
        this.$set(this.search,0,false);
        this.$set(this.search,1,true);
      }
    },
    //检索接口
    searchAPI(type,woundType,conversion,keyword,woundLevel,woundTypeOther,inspectTime){
      this.loading=true;
      this.API.get('/api/search/list',{
          'type':type,
          'woundType':woundType,
          'woundLevel':woundLevel,
          'woundTypeOther':woundTypeOther,
          'conversion':conversion,
          'keyword':keyword,
          'inspectTime':inspectTime
        })
      .then(res=>{
        if(res.code==0){
          let sum=0;
          for(let i in res.data){
            sum+=res.data[i].length;
          }
          if(sum==0){
            this.$message({
              type:'info',
              message:'暂无数据',
              duration:1000
            })
          }
          this.allSickList=res.data;
        }else{
          this.$message({
            type:'info',
            message:res.message,
            duration:1000
          })
        }
      })
      .catch((err)=>{
        this.$message({
          type:'error',
          message:err.message,
          duration:1000
        })
      })
      .finally(()=>{
        this.loading=false;
      })
    },
    // 
    one(id,name){
      this.title=name;
      this.num=id-1;
      this.skShow=false;
    },
    //检索伤口类型人群
    searchWoungType(woundType,name,item){
      if(name=='压疮'){
        this.buttonList=item.woundLevel;
      }else if(name=='瘘'|| name=="造口并发症" ||name=="风湿免疫系统疾病相关溃疡"){
        this.buttonList=item.children;
      }else{
        this.buttonList=[];
      }
      this.woundType=woundType;
      this.searchAPI(this.searchType,woundType);
      this.title=name+'患者列表'
      this.$set(this.search,1,true);
      this.$set(this.search,2,false);
    },
    // 转归一览查询
    zgylSearch(type,woundType,index,keyword){
      this.conversion=index+1;
      let len=document.getElementsByClassName('allButton').length;
      for(let i=0;i<len;i++){
        document.getElementsByClassName('allButton')[i].style.backgroundColor='rgb(166,166,166)';
      }
      document.getElementsByClassName('allButton')[index].style.backgroundColor='#409EFF';
      this.searchAPI(type,woundType,this.conversion,keyword);
    },
    backTo(){
      this.search=[true,false,false,false];
      this.title="同步归档与检索";
      this.conversion=null;
      this.keyword='';
      this.woundType=null;
      this.skShow=true;
      this.buttonList=[];
      this.tootip=true;
      this.months='';
    },
    //查看患者信息
    lookInfo(id,name,cardId){
      this.loading=true;
      this.API.get('/api/patient/info/getWoundList',{'patientId':id,})
      .then(res=>{
        if(res.code==0){
          this.$store.commit('setCardID1',cardId);
          this.$store.commit('historySet',res.data)
          this.$router.push({
            name:'sickWound',
            params:{
              path:'/searchArchive',
              name:name,
              old:false
            }
          })
        }else{
          this.$message({
            type:'info',
            message:res.message,
            duration:1000
          })
        }
      })
      .catch((err)=>{
        this.$message({
          type:'error',
          message:err.message,
          duration:1000
        })
      })
      .finally(()=>{
        this.loading=false;
      })
    },
    getTypeOf(){
      this.loading=true;
      this.API.get('/api/wound/type/list')
      .then((res)=>{
        if(res.code==0){
          this.allWoundType=res.data;
        }else{
          this.$message({
            type:'info',
            message:'获取伤口类型列表失败：'+res.message,
            duration:1000
          })
        }
      })
      .catch((err)=>{
        this.$message({
            type:'error',
            message:'获取伤口类型列表失败：'+err.message,
            duration:1000
          })
      })
      .finally(()=>{
        this.loading=false;
      })
    },
  },
  created(){
    this.getAllSearch();
    if(this.$store.state.allWoundType.length>0){
      this.allWoundType=this.$store.state.allWoundType;
    }else{
      this.getTypeOf();
    };
    this.Years=new Date().getFullYear();
    for(let i=0;i<10;i++){
      this.yearsList.push({
        value:this.Years-i,
        label:this.Years-i+'年'
      })
    };
  }
}
</script>

<style>
@import url('./searchArchive.css');
</style>


