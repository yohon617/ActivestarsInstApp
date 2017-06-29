import { ActivestarsInstAppPage } from './app.po';

describe('activestars-inst-app App', () => {
  let page: ActivestarsInstAppPage;

  beforeEach(() => {
    page = new ActivestarsInstAppPage();
  });

  it('should display welcome message', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('Welcome to app!!');
  });
});
