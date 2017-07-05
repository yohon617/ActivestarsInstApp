import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { ClassesComponent }   from './classes/classes.component';
import { OrderComponent }      from './order/order.component';
import { ReportComponent }  from './report/report.component';
import { RosterComponent }  from './roster/roster.component';

const routes: Routes = [
  { path: '', redirectTo: '/classes', pathMatch: 'full' },
  { path: 'start.asp', redirectTo: '/classes', pathMatch: 'full' },
  { path: 'classes', component: ClassesComponent },
  { path: 'roster', component: RosterComponent },
  { path: 'report', component: ReportComponent },
  { path: 'order', component: OrderComponent }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {}
