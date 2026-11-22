import {originalAssetNames, originalAssetInfo, originalAssetElement} from '../../primecare_ui/web/original-asset-view';
import {PrimeComponentFactory, type CatalogueLocale} from '../../primecare_ui/web/component-catalogue';
import {PrimeDataControls} from '../../primecare_ui/web/data-controls';
import {PrimeDashboardWidgets} from '../../primecare_ui/web/dashboard-widgets';
import {kitchenSinkCatalog, componentMetadata} from '../../primecare_kitchen_sink_catalog/src/index';
import packageCatalog from '../../primecare_package_base/catalog.json';
import {theme} from '../../domain/src/theme_config';
export {PrimeComponentFactory, PrimeDataControls, PrimeDashboardWidgets};
export {kitchenSinkCatalog} from '../../primecare_kitchen_sink_catalog/src/index';
export type KitchenSinkLocale = CatalogueLocale;
type Story = typeof kitchenSinkCatalog.stories[number];
const owners = new WeakMap<HTMLElement, () => void>();
let sequence = 0;
const words = kitchenSinkCatalog.labels;

/** Developer-only composition. Never mounts a production business route or supplies authorization. */
export function mountKitchenSink(root: HTMLElement, options: {locale?: KitchenSinkLocale; theme?: 'light'|'dark'; bridgeTheme?: boolean} = {}) {
  if (root === root.ownerDocument.body || root === root.ownerDocument.documentElement) throw Error('Scoped showcase root required');
  const firstLocale = options.locale ?? 'en';
  if (!Object.hasOwn(words, firstLocale)) throw Error('Unsupported kitchen sink locale');
  owners.get(root)?.();
  const instance = 'ks-' + ++sequence, doc = root.ownerDocument;
  const previous = {children:[...root.childNodes], marker:root.getAttribute('data-pc-kitchen-sink'), theme:root.getAttribute('data-theme'), style:root.getAttribute('style')};
  let locale = firstLocale, disposed = false, query = '', category = 'all';
  let events = new AbortController();
  const cleanup: (() => void)[] = [], state = new Map<string, unknown>();
  const cards = new Map<string, HTMLElement>();
  const node = <K extends keyof HTMLElementTagNameMap>(tag: K, text?: string, testId?: string) => {
    const value = doc.createElement(tag); if (text !== undefined) value.textContent = text;
    if (testId) value.dataset.cy = testId; return value;
  };
  const active = () => !disposed && owners.get(root) === dispose && root.isConnected;
  function stopExamples() {
    const errors:unknown[]=[];
    for (const stop of cleanup.splice(0).reverse()) {try {stop();}catch(error){errors.push(error);}}
    cards.clear(); if(errors.length)throw new AggregateError(errors,'Kitchen sink cleanup failed');
  }
  function dispose() {
    if (disposed) return; disposed = true; events.abort();
    try {stopExamples();} finally {
      if (owners.get(root) === dispose) {
        owners.delete(root); root.replaceChildren(...previous.children);
        for (const [attribute, value] of [['data-pc-kitchen-sink',previous.marker],['data-theme',previous.theme],['style',previous.style]] as const)
          value === null ? root.removeAttribute(attribute) : root.setAttribute(attribute,value);
      }
    }
  }
  owners.set(root, dispose); root.dataset.pcKitchenSink = instance; root.dataset.theme = options.theme ?? 'light';
  if (options.bridgeTheme) {
    const aliases: Record<string,string> = {'--color-primary':'var(--pc-primary)', '--color-on-primary':'var(--pc-text-on-primary)',
      '--color-text':'var(--pc-text-primary)', '--color-text-muted':'var(--pc-text-secondary)', '--color-border':'var(--pc-border-primary)',
      '--color-background':'var(--pc-bg-secondary)', '--color-surface':'var(--pc-surface-card)', '--color-error':'var(--pc-error)',
      '--color-success':'var(--pc-success)', '--color-warning':'var(--pc-warning)', '--radius-md':'var(--pc-radius-md)',
      '--spacing-unit':theme.spacing.sm, '--spacing-sm':theme.spacing.sm, '--spacing-md':theme.spacing.md,
      '--spacing-lg':theme.spacing.lg, '--border-width':`calc(${theme.spacing.xs} / 4)`,
      '--control-min-height':`calc(${theme.spacing.lg} * 2)`};
    for (const [key,value] of Object.entries(aliases)) root.style.setProperty(key,value);
  }
  function filter() {
    let count = 0;
    for (const story of kitchenSinkCatalog.stories) {
      const visible = (category === 'all' || category === story.category) &&
        `${story.id} ${story.titles[locale]} ${story.webSymbol} ${story.webSource}`.toLocaleLowerCase(locale).includes(query.toLocaleLowerCase(locale));
      const card = cards.get(story.id); if (card) card.hidden = !visible; if (visible) count++;
    }
    const result = root.querySelector<HTMLElement>('[data-cy=ks-results]');
    if (result) result.textContent = count ? `${count} / ${kitchenSinkCatalog.stories.length}` : words[locale].none;
  }
  function example(story: Story, host: HTMLElement) {
    const scope = `${instance}-${story.id}`, labels = componentMetadata.locales[locale];
    const registration = {...componentMetadata, controls:componentMetadata.controls.map(control => ({...control,testId:control.testId+'-'+scope}))};
    const output = node('output', String(state.get(story.id) ?? ''), 'ks-output-'+story.id); output.setAttribute('aria-live','polite');
    const changed = (value: unknown) => {if (active()) {state.set(story.id,value); output.textContent = String(value);}};
    const plain = (text = labels.success) => node('p',text);
    if (story.family === 'data-controls') {
      const kit = new PrimeDataControls(host, scope, locale); cleanup.push(() => kit.dispose());
      if (story.id === 'table') host.append(kit.table(
        [{key:'name',label:labels.input,width:180,visible:true,pinned:true},{key:'status',label:labels.status,width:140,visible:true,pinned:false}],
        Array.from({length:12},(_,i)=>({id:'row-'+i,values:{name:`${words[locale].demo} ${i+1}`,status:labels.success}})),
        {rowHeight:48,height:240,minWidth:100,maxWidth:500,actionWidth:160,pageSize:6}).element);
      else if (story.id === 'autocomplete') host.append(kit.autocomplete(async () => [{value:'one',label:labels.optionOne},{value:'two',label:labels.optionTwo}], changed));
      else {const field=kit.field(story.id as 'date'|'time'|'number'|'mask', story.id==='number'?{min:0,max:100}:{},String(state.get(story.id)??''));field.input.addEventListener('input',()=>changed(field.input.value),{signal:events.signal});host.append(field.element);}
      host.append(output); return;
    }
    if (story.family === 'dashboard-widgets') {
      const kit = new PrimeDashboardWidgets(host,scope,locale); cleanup.push(() => kit.dispose());
      if (story.id === 'metric') host.append(kit.metric(labels.status,24,words[locale].demo,'-'+scope));
      else host.append(kit.chart({kind:story.id as 'line'|'area'|'bar'|'donut',title:story.titles[locale],
        categories:[labels.optionOne,labels.optionTwo,labels.status],series:[{id:'demo',label:words[locale].demo,values:[12,18,9]}]},
        {width:420,height:220,stroke:2},'-'+scope));
      return;
    }
    const kit = new PrimeComponentFactory(host,scope,locale,registration); cleanup.push(() => kit.dispose());
    const textField = (key: 'input'|'multiline', required=false) => {
      const fieldKey=story.id+':'+key;
      const field = kit.field(key,{value:String(state.get(fieldKey)??''),required});
      field.input.addEventListener('input',()=>{state.set(fieldKey,field.input.value);changed(field.input.value);},{signal:events.signal}); return field.element;
    };
    switch (story.id) {
      case 'button': host.append(kit.button('button',()=>changed(Number(state.get(story.id)??0)+1),{suffix:'-normal'}),
        kit.button('button',undefined,{disabled:true,suffix:'-disabled'}),kit.button('button',()=>{}, {pressed:true,suffix:'-pressed'})); break;
      case 'input': case 'multiline': host.append(textField(story.id)); break;
      case 'select': {const select=kit.select('select',[{value:'one',label:labels.optionOne},{value:'two',label:labels.optionTwo}],changed);const input=select.querySelector('select');if(input&&state.has(story.id))input.value=String(state.get(story.id));host.append(select);break;}
      case 'checkbox': case 'switch': host.append(kit.boolean(story.id,Boolean(state.get(story.id)),changed)); break;
      case 'radio': host.append(kit.radio([{value:'one',label:labels.optionOne},{value:'two',label:labels.optionTwo}],String(state.get(story.id)??''),changed)); break;
      case 'card': host.append(kit.card('card',[plain()])); break;
      case 'badge': host.append(kit.badge(labels.success)); break;
      case 'menu': host.append(kit.menu([{label:labels.menuItem,action:()=>changed(labels.success)},{label:labels.cancel,disabled:true,action:()=>{}}])); break;
      case 'tabs': host.append(kit.tabs([{key:'tabOne',content:plain(labels.optionOne)},{key:'tabTwo',content:plain(labels.optionTwo)}])); break;
      case 'accordion': host.append(kit.accordion(plain())); break;
      case 'tooltip': host.append(kit.tooltip(labels.tooltip)); break;
      case 'dialog': case 'drawer': host.append(kit.modal(story.id,plain(),story.id==='dialog'?async()=>changed(labels.success):undefined)); break;
      case 'form': host.append(kit.form([textField('input',true),textField('multiline')],async()=>changed(labels.success))); break;
      case 'loading': case 'splash': case 'empty': case 'error': host.append(kit.state(story.id,async()=>changed(labels.success))); break;
      case 'toast': host.append(kit.feedback(labels.success)); break;
      case 'code': host.append(kit.code('const kit = new PrimeComponentFactory(root, scope);')); break;
      case 'preview': host.append(kit.preview(plain())); break;
      case 'countdown': host.append(kit.countdown(Date.now()+60_000).element); break;
      case 'async': host.append(kit.asyncRegion('card',scope,async()=>labels.success,value=>plain(value)).element); break;
    }
    host.append(output);
  }
  function render() {
    stopExamples(); events.abort(); events = new AbortController(); root.replaceChildren();
    const w=words[locale], header=node('header'), title=node('h1',w.title), note=node('p',w.note);
    header.append(title,note); root.append(header);
    const tools=node('nav',undefined,'ks-toolbar'); tools.setAttribute('aria-label',w.preview);
    const search=node('input',undefined,'ks-search');search.type='search';search.value=query;search.placeholder=w.search;search.setAttribute('aria-label',w.search);
    search.addEventListener('input',()=>{query=search.value;filter();},{signal:events.signal});
    const categories=node('select',undefined,'ks-category');categories.setAttribute('aria-label',w.all);
    for(const value of ['all',...new Set(kitchenSinkCatalog.stories.map(s=>s.category))]){const option=node('option',value==='all'?w.all:w.categories[value as keyof typeof w.categories]);option.value=value;categories.append(option);}categories.value=category;
    categories.addEventListener('change',()=>{category=categories.value;filter();},{signal:events.signal});
    const language=node('select',undefined,'ks-locale');language.setAttribute('aria-label',w.language);
    for(const [value,label] of [['en','English'],['fr','Français'],['es','Español']]){const option=node('option',label);option.value=value;language.append(option);}language.value=locale;
    language.addEventListener('change',()=>{locale=language.value as KitchenSinkLocale;render();},{signal:events.signal});
    const palette=node('button',w.theme,'ks-theme');palette.type='button';palette.setAttribute('aria-pressed',String(root.dataset.theme==='dark'));
    palette.addEventListener('click',()=>{root.dataset.theme=root.dataset.theme==='dark'?'light':'dark';palette.setAttribute('aria-pressed',String(root.dataset.theme==='dark'));},{signal:events.signal});
    const results=node('output',undefined,'ks-results');results.setAttribute('aria-live','polite');tools.append(search,categories,language,palette,results);root.append(tools);
    const grid=node('div',undefined,'ks-grid');root.append(grid);
    for(const story of kitchenSinkCatalog.stories){
      const card=node('article',undefined,'ks-story-'+story.id);card.className='ks-story';cards.set(story.id,card);grid.append(card);
      const heading=node('h2',story.titles[locale]), symbol=node('code',story.webSymbol), host=node('section',undefined,'ks-preview-'+story.id);host.className='ks-preview';
      const details=node('details'), summary=node('summary',w.source), code=node('pre',`${story.webSymbol}\n${story.webSource}\n${story.exampleKind}`);
      details.append(summary,code);card.append(heading,symbol,host,details);example(story,host);
    }
    const references=node('details',undefined,'ks-references');references.append(node('summary',`${w.reference} · ${kitchenSinkCatalog.references.length}`));
    for(const reference of kitchenSinkCatalog.references){const row=node('section');row.append(node('h3',reference.id),node('p',`${reference.mapped?w.mapped:w.unmapped} · ${w.pending}`),node('code',reference.web??reference.flutter??reference.id),node('p',reference.scope));references.append(row);}root.append(references);
    const assets=node('details',undefined,'ks-assets');assets.append(node('summary',`${w.assets} (${originalAssetNames.length})`),node('p',w.assetNote));
    const assetGrid=node('div',undefined,'ks-assets-grid');
    for(const key of originalAssetNames){
      const info=originalAssetInfo(key),figure=node('figure',undefined,'ks-asset-'+key);
      figure.append(originalAssetElement(key,{width:info.category==='icon'?48:160,height:96,decorative:true,suffix:'-'+instance,document:doc}),node('figcaption',key));
      assetGrid.append(figure);
    }
    assets.append(assetGrid);root.append(assets);
    const packages=node('details',undefined,'ks-packages');packages.append(node('summary',w.packages));
    const table=node('table'), head=node('tr');for(const label of [w.owner,w.dependencies,w.hosting])head.append(node('th',label));table.append(head);
    for(const entry of packageCatalog.packages){const row=node('tr');for(const text of [entry.path,entry.dependencies.join(', ')||'—',entry.hosting])row.append(node('td',text));table.append(row);}packages.append(table);root.append(packages);
    filter();
  }
  try { render(); } catch(error) { dispose(); throw error; }
  return {dispose, setLocale(next:KitchenSinkLocale){if(!Object.hasOwn(words,next))throw Error('Unsupported kitchen sink locale');if(disposed)throw Error('Showcase disposed');locale=next;render();},
    setFilter(next:string){if(disposed)throw Error('Showcase disposed');query=next;filter();}, root};
}
