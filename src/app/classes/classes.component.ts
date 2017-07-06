import { Component } from '@angular/core';

import { ClassService } from './../services/class/class.service';

@Component({
  selector: 'app-root',
  templateUrl: './classes.component.html',
  styleUrls: ['./classes.component.css']
})
export class ClassesComponent {
    
    constructor(private classService: ClassService) { }

    
}
