/*
THIS IS A GENERATED/BUNDLED FILE BY ESBUILD
if you want to view the source, please visit the github repository of this plugin
*/

var __create = Object.create;
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __getProtoOf = Object.getPrototypeOf;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toESM = (mod, isNodeMode, target) => (target = mod != null ? __create(__getProtoOf(mod)) : {}, __copyProps(
  // If the importer is in node compatibility mode or this is not an ESM
  // file that has been converted to a CommonJS file using a Babel-
  // compatible transform (i.e. "__esModule" has not been set), then set
  // "default" to the CommonJS "module.exports" for node compatibility.
  isNodeMode || !mod || !mod.__esModule ? __defProp(target, "default", { value: mod, enumerable: true }) : target,
  mod
));
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// main.ts
var main_exports = {};
__export(main_exports, {
  default: () => VimImPlugin
});
module.exports = __toCommonJS(main_exports);
var import_obsidian = require("obsidian");
var os = __toESM(require("os"));
var DEFAULT_SETTINGS = {
  defaultIM: "",
  obtainCmd: "",
  switchCmd: "",
  windowsDefaultIM: "",
  windowsObtainCmd: "",
  windowsSwitchCmd: ""
};
var VimImPlugin = class extends import_obsidian.Plugin {
  constructor() {
    super(...arguments);
    this.currentInsertIM = "";
    this.previousMode = "";
    this.isWinPlatform = false;
  }
  async onload() {
    await this.loadSettings();
    this.app.workspace.on("file-open", async (_file) => {
      const view = this.getActiveView();
      if (view) {
        const editor = this.getCodeMirror(view);
        if (editor) {
          editor.on("vim-mode-change", (modeObj) => {
            if (modeObj) {
              this.onVimModeChanged(modeObj);
            }
          });
        }
      }
    });
    this.addSettingTab(new SampleSettingTab(this.app, this));
    console.debug("VimIm::OS type: " + os.type());
    this.isWinPlatform = os.type() == "Windows_NT";
    this.currentInsertIM = this.isWinPlatform ? this.settings.windowsDefaultIM : this.settings.defaultIM;
    if (this.isWinPlatform) {
      console.debug("VimIm Use Windows config");
    }
  }
  getActiveView() {
    return this.app.workspace.getActiveViewOfType(import_obsidian.MarkdownView);
  }
  getCodeMirror(view) {
    var _a, _b, _c;
    return (_c = (_b = (_a = view.sourceMode) == null ? void 0 : _a.cmEditor) == null ? void 0 : _b.cm) == null ? void 0 : _c.cm;
  }
  switchToInsert() {
    const { exec } = require("child_process");
    let switchToInsert;
    if (this.currentInsertIM) {
      switchToInsert = this.isWinPlatform ? this.settings.windowsSwitchCmd.replace(/{im}/, this.currentInsertIM) : this.settings.switchCmd.replace(/{im}/, this.currentInsertIM);
    }
    console.debug("change to insert");
    if (typeof switchToInsert != "undefined" && switchToInsert) {
      exec(switchToInsert, (error, stdout, stderr) => {
        if (error) {
          console.error(`switch error: ${error}`);
          return;
        }
        console.debug(`switch im: ${switchToInsert}`);
      });
    }
    this.previousMode = "insert";
  }
  switchToNormal() {
    const { exec } = require("child_process");
    const switchFromInsert = this.isWinPlatform ? this.settings.windowsSwitchCmd.replace(/{im}/, this.settings.windowsDefaultIM) : this.settings.switchCmd.replace(/{im}/, this.settings.defaultIM);
    const obtainc = this.isWinPlatform ? this.settings.windowsObtainCmd : this.settings.obtainCmd;
    console.debug("change to noInsert");
    if (typeof obtainc != "undefined" && obtainc) {
      exec(obtainc, (error, stdout, stderr) => {
        if (error) {
          console.error(`obtain error: ${error}`);
          return;
        }
        this.currentInsertIM = stdout;
        console.debug(`obtain im: ${this.currentInsertIM}`);
      });
    }
    if (typeof switchFromInsert != "undefined" && switchFromInsert) {
      exec(switchFromInsert, (error, stdout, stderr) => {
        if (error) {
          console.error(`switch error: ${error}`);
          return;
        }
        console.debug(`switch im: ${switchFromInsert}`);
      });
    }
    this.previousMode = "normal";
  }
  onVimModeChanged(modeObj) {
    switch (modeObj.mode) {
      case "insert":
        this.switchToInsert();
        break;
      default:
        if (this.previousMode != "insert") {
          break;
        }
        this.switchToNormal();
        break;
    }
  }
  onunload() {
    console.debug("onunload");
  }
  async loadSettings() {
    this.settings = Object.assign({}, DEFAULT_SETTINGS, await this.loadData());
  }
  async saveSettings() {
    await this.saveData(this.settings);
  }
};
var SampleSettingTab = class extends import_obsidian.PluginSettingTab {
  constructor(app, plugin) {
    super(app, plugin);
    this.plugin = plugin;
  }
  display() {
    const { containerEl } = this;
    containerEl.empty();
    containerEl.createEl("h2", { text: "Vim IM Select Settings." });
    containerEl.createEl("h3", { text: "Settings for default platform." });
    new import_obsidian.Setting(containerEl).setName("Default IM").setDesc("IM for normal mode").addText((text) => text.setPlaceholder("Default IM").setValue(this.plugin.settings.defaultIM).onChange(async (value) => {
      console.debug("Default IM: " + value);
      this.plugin.settings.defaultIM = value;
      await this.plugin.saveSettings();
    }));
    new import_obsidian.Setting(containerEl).setName("Obtaining Command").setDesc("Command for obtaining current IM(must be excutable)").addText((text) => text.setPlaceholder("Obtaining Command").setValue(this.plugin.settings.obtainCmd).onChange(async (value) => {
      console.debug("Obtain Cmd: " + value);
      this.plugin.settings.obtainCmd = value;
      await this.plugin.saveSettings();
    }));
    new import_obsidian.Setting(containerEl).setName("Switching Command").setDesc("Command for switching to specific IM(must be excutable)").addText((text) => text.setPlaceholder("Use {im} as placeholder of IM").setValue(this.plugin.settings.switchCmd).onChange(async (value) => {
      console.debug("Switch Cmd: " + value);
      this.plugin.settings.switchCmd = value;
      await this.plugin.saveSettings();
    }));
    containerEl.createEl("h3", { text: "Settings for Windows platform." });
    new import_obsidian.Setting(containerEl).setName("Windows Default IM").setDesc("IM for normal mode").addText((text) => text.setPlaceholder("Default IM").setValue(this.plugin.settings.windowsDefaultIM).onChange(async (value) => {
      console.debug("Default IM: " + value);
      this.plugin.settings.windowsDefaultIM = value;
      await this.plugin.saveSettings();
    }));
    new import_obsidian.Setting(containerEl).setName("Obtaining Command on Windows").setDesc("Command for obtaining current IM(must be excutable)").addText((text) => text.setPlaceholder("Obtaining Command").setValue(this.plugin.settings.windowsObtainCmd).onChange(async (value) => {
      console.debug("Obtain Cmd: " + value);
      this.plugin.settings.windowsObtainCmd = value;
      await this.plugin.saveSettings();
    }));
    new import_obsidian.Setting(containerEl).setName("Switching Command on Windows").setDesc("Command for switching to specific IM(must be excutable)").addText((text) => text.setPlaceholder("Use {im} as placeholder of IM").setValue(this.plugin.settings.windowsSwitchCmd).onChange(async (value) => {
      console.debug("Switch Cmd: " + value);
      this.plugin.settings.windowsSwitchCmd = value;
      await this.plugin.saveSettings();
    }));
  }
};

/* nosourcemap */