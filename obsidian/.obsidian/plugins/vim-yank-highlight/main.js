/*
THIS IS A GENERATED/BUNDLED FILE BY ESBUILD
if you want to view the source, please visit the github repository of this plugin
*/

var h=Object.defineProperty;var V=Object.getOwnPropertyDescriptor;var v=Object.getOwnPropertyNames;var E=Object.prototype.hasOwnProperty;var w=(r,e)=>{for(var i in e)h(r,i,{get:e[i],enumerable:!0})},k=(r,e,i,o)=>{if(e&&typeof e=="object"||typeof e=="function")for(let t of v(e))!E.call(r,t)&&t!==i&&h(r,t,{get:()=>e[t],enumerable:!(o=V(e,t))||o.enumerable});return r};var M=r=>k(h({},"__esModule",{value:!0}),r);var y={};w(y,{default:()=>c});module.exports=M(y);var l=require("obsidian");var p=require("@codemirror/state"),d=require("@codemirror/view");function f(r,e){let i=r.length,o=e.length,t=[];for(let n=0;n<=i;n++){t[n]=[];for(let s=0;s<=o;s++)t[n][s]=0}let a="",m=0;for(let n=0;n<i;n++)for(let s=0;s<o;s++)r[n]===e[s]&&(t[n+1][s+1]=t[n][s]+1,t[n+1][s+1]>m&&(m=t[n+1][s+1],a=r.substring(n-m+1,n+1)));return a}var u=class{constructor(e){this.decorations=this.buildDecorations(e)}update(e){e instanceof d.EditorView?(this.decorations=this.buildDecorations(e),e.dispatch()):(e.docChanged||e.viewportChanged)&&(this.decorations=this.buildDecorations(e.view))}setYankText(e,i){return this.cleanYankText(i),this.yankText=e,this.update(i),this}cleanYankText(e){return this.yankText=null,this.update(e),this}destroy(){}buildDecorations(e){let i=new p.RangeSetBuilder;if(this.cursorHead=null,!this.yankText||e.state.doc.length===0)return i.finish();let o=e.viewport,t=e.state.sliceDoc(o.from,o.to)+`
`,a=f(t,this.yankText),m=this.getSubstringPosition(e,t,a),n=o.from+m,s=n+a.length;return i.add(n,s,d.Decoration.mark({class:"ovy-highlight"})),i.finish()}getSubstringPosition(e,i,o){this.cursorHead=this.cursorHead||e.state.selection.main.head-e.viewport.from;let t=i.indexOf(o);for(;t!==-1&&!(t<=this.cursorHead&&this.cursorHead<=t+o.length);){if(t>this.cursorHead)break;t=i.indexOf(o,t+1)}return t}},x={decorations:r=>r.decorations},g=d.ViewPlugin.fromClass(u,x);var C=require("obsidian");var c=class extends l.Plugin{constructor(){super(...arguments);this.vimCommand=[];this.vimCommandDone=!1;this.onVimKeypress=i=>{this.vimCommand.push(i),this.vimCommandDone&&((this.vimCommand.contains("y")||this.vimCommand.contains("Y"))&&this.highlightYank(),this.vimCommandDone=!1,this.vimCommand.splice(0,this.vimCommand.length))};this.onVimCommandDone=()=>{this.vimCommandDone=!0}}get activeView(){return this.app.workspace.getActiveViewOfType(l.MarkdownView)}get activeEditorView(){var i,o;return(o=((i=this.activeView)==null?void 0:i.leaf.view).editor)==null?void 0:o.cm}get codeMirror(){var i,o,t,a;return(a=(t=(o=(i=this.activeView)==null?void 0:i.editMode)==null?void 0:o.editor)==null?void 0:t.cm)==null?void 0:a.cm}async onload(){this.registerEditorExtension([g]),this.registerEvent(this.app.workspace.on("active-leaf-change",()=>{this.initialized||this.initialize()}))}initialize(){var i;if(this.activeView&&this.codeMirror){this.codeMirrorVimObject=(i=window.CodeMirrorAdapter)==null?void 0:i.Vim;let o=this.codeMirror;o.off("vim-keypress",this.onVimKeypress),o.on("vim-keypress",this.onVimKeypress),o.off("vim-command-done",this.onVimCommandDone),o.on("vim-command-done",this.onVimCommandDone)}}highlightYank(){let o=this.codeMirrorVimObject.getRegisterController().getRegister("yank").keyBuffer[0];if(!this.activeEditorView)return;let t=this.activeEditorView.plugin(g);t.setYankText(o,this.activeEditorView);let a=this.activeEditorView;clearTimeout(this.timeoutHandle),this.timeoutHandle=window.setTimeout(()=>{t.cleanYankText(a)},500)}onunload(){let i=this.codeMirror;i&&(i.off("vim-keypress",this.onVimKeypress),i.off("vim-command-done",this.onVimCommandDone))}};

/* nosourcemap */