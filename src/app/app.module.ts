import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule }   from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppRoutingModule } from './app-routing.module';

import { AppComponent } from './app.component';
import { ClassDropdownComponent } from './classDropdown/class-dropdown.component';
import { ClassesComponent }   from './classes/classes.component';
import { OrderComponent }      from './order/order.component';
import { ReportComponent }  from './report/report.component';
import { RosterComponent } from './roster/roster.component';

import { BsDropdownModule } from 'ngx-bootstrap/dropdown';

import { ClassService } from './services/class/class.service'
import { ClassAPIService } from './services/class/class-api.service'

@NgModule({
  declarations: [
      AppComponent,
      ClassDropdownComponent,
      ClassesComponent,
      OrderComponent,
      ReportComponent,
      RosterComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    AppRoutingModule,
    BsDropdownModule.forRoot()
  ],
  providers: [ClassService, ClassAPIService],
  bootstrap: [AppComponent]
})
export class AppModule { }
