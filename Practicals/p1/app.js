/* Keelan Matthews 21549967 */
new Vue({
	el:'#root',
  data: {
    item:"",
    list:[
    	{ text:"Catch up on IMY210"},
      { text:"Raid Yan Wong's twitch chat"},
      { text:"Make absolutely zero coffee"}
    ]
  },
  methods: {
  	add_item: function(){
    	return this.list.push({text:this.item});
    }
  }
  
})