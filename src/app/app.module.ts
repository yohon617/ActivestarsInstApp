import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule }   from '@angular/forms';
import { HttpModule }    from '@angular/http';

import { AppComponent } from './app.component';
import { ClassDropdownComponent } from './classDropdown/class-dropdown.component'

import { ClassService } from './services/class/class.service'

@NgModule({
  declarations: [
      AppComponent,
      ClassDropdownComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule
  ],
  providers: [ ClassService ],
  bootstrap: [AppComponent]
})
export class AppModule { }
