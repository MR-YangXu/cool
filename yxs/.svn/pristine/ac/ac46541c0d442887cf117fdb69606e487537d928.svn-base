<template>
    <div class="container">
        <el-row :gutter="20">
            <el-col :span="6"><div :class="{active1:indexShow1}" @click="path(1)"><icon name="1" width="40" height="40"></icon><span class="textCenter">患者登记</span></div></el-col>
            <el-col :span="6"><div :class="{active2:indexShow2}" @click="path(2)"><icon name="2" width="40" height="40"></icon><span class="textCenter">伤口记录</span></div></el-col>
            <el-col :span="6"><div :class="{active3:indexShow3}" @click="path(3)"><icon name="3" width="40" height="40"></icon><span class="textCenter">愈合变化</span></div></el-col>
            <el-col :span="6"><div :class="{active4:indexShow4}" @click="path(4)"><icon name="4" width="40" height="40"></icon><span class="textCenter">同步归档</span></div></el-col>
        </el-row>
    </div>
</template>

<script>
export default {
    name:'foot',
    props:['index','save'],
    data(){
        return {
            indexShow1:false,
            indexShow2:false,
            indexShow3:false,
            indexShow4:false,
            N:0
        }
    },
    mounted(){
        this.N=this.$store.state.Num;

        if(this.index==1){
            this.indexShow2=false;
            this.indexShow1=true;
            this.indexShow3=false;
            this.indexShow4=false;
        }else if(this.index==2){
            this.indexShow1=false;
            this.indexShow2=true;
            this.indexShow3=false;
            this.indexShow4=false;
        }else if(this.index==3){
            this.indexShow1=false;
            this.indexShow2=false;
            this.indexShow3=true;
            this.indexShow4=false;
        }else if(this.index==4){
            this.indexShow1=false;
            this.indexShow2=false;
            this.indexShow3=false;
            this.indexShow4=true;
        }
    },
    methods:{
        deleteNone(){
            this.API.get('/api/patient/wound/deleteEmptyWound',{'parentId':this.$store.state.sickMessage.id})
            .then((res)=>{
                if(res.code==0){
                }else{
                    this.$message({
                        type:'info',
                        message:res.message
                    })
                }
            })
            .catch((err)=>{
                this.$message({
                    type:'error',
                    message:err.message
                })
            })
        },
        path(i){
            if(this.$store.state.cardID){
                if(this.N==2&&!this.save){
                    this.$confirm('是否离开当前页面？','提示',{
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'info',
                        center: true
                    })
                    .then (() => {
                        this.deleteNone();
                        if(i==1){
                            this.$router.push({
                                path:'/sickMessage'
                            })
                        }else if(i==2){
                            this.$router.push({
                                path:'/chulifangshi'
                            })
                        }else if(i==3){
                            this.$router.push({
                                path:'/change'
                            })
                        }else if(i==4){
                            this.$router.push({
                                path:'/searchArchive'
                            })
                        };
                    })
                }else{
                    if(this.$route.path=='/chulifangshi'){
                        this.deleteNone();
                    }
                    if(i==1){
                        this.$router.push({
                            path:'/sickMessage'
                        })
                    }else if(i==2){
                        this.$router.push({
                            path:'/chulifangshi'
                        })
                    }else if(i==3){
                        this.$router.push({
                            path:'/change'
                        })
                    }else if(i==4){
                        this.$router.push({
                            path:'/searchArchive'
                        })
                    };
                }
                this.$store.commit('setNum',i);
            }else{
                if(i==4){
                    this.$router.push({
                        path:'/searchArchive'
                    })
                }else if(i==1){
                    this.$router.push('/index');
                }else{
                    this.$message({
                        type:'info',
                        message:'请先输入患者ID'
                    });
                }
            }
        }
    }
}
</script>

<style scoped>
.container{
    width: 100%;
    height: 73px;
    font-size: 18px;
    text-align: center;
    border-top: 2px solid #2e96e6;
    padding: 5px 0 0;
    background-color: #fff;
    z-index: 10;
}
.textCenter{
    display: block;
    text-align: center;
}
.active1{
    color:#2e96e6;
}
.active2{
    color:#2e96e6;
}
.active3{
    color:#2e96e6;
}
.active4{
    color:#2e96e6;
}
</style>

