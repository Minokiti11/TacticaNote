// @uppy/utils/lib/VirtualList@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/VirtualList.js

import{Component as t,h as e}from"preact";function _extends(){return _extends=Object.assign?Object.assign.bind():function(t){for(var e=1;e<arguments.length;e++){var s=arguments[e];for(var i in s)({}).hasOwnProperty.call(s,i)&&(t[i]=s[i])}return t},_extends.apply(null,arguments)}const s={position:"relative",width:"100%",minHeight:"100%"};const i={position:"absolute",top:0,left:0,width:"100%",overflow:"visible"};class VirtualList extends t{constructor(t){super(t);this.handleScroll=()=>{this.setState({offset:this.base.scrollTop})};this.handleResize=()=>{this.resize()};this.focusElement=null;this.state={offset:0,height:0}}componentDidMount(){this.resize();window.addEventListener("resize",this.handleResize)}componentWillUpdate(){this.base.contains(document.activeElement)&&(this.focusElement=document.activeElement)}componentDidUpdate(){this.focusElement&&this.focusElement.parentNode&&document.activeElement!==this.focusElement&&this.focusElement.focus();this.focusElement=null;this.resize()}componentWillUnmount(){window.removeEventListener("resize",this.handleResize)}resize(){const{height:t}=this.state;t!==this.base.offsetHeight&&this.setState({height:this.base.offsetHeight})}render(t){let{data:n,rowHeight:o,renderRow:l,overscanCount:h=10,...r}=t;const{offset:a,height:c}=this.state;let d=Math.floor(a/o);let f=Math.floor(c/o);if(h){d=Math.max(0,d-d%h);f+=h}const u=d+f+4;const m=n.slice(d,u);const p={...s,height:n.length*o};const v={...i,top:d*o};return e("div",_extends({onScroll:this.handleScroll},r),e("div",{role:"presentation",style:p},e("div",{role:"presentation",style:v},m.map(l))))}}export{VirtualList as default};

