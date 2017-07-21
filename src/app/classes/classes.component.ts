import { Component } from '@angular/core';

import { ClassService } from './../services/class/class.service';
import { ConfigService } from './../config/config.service';

@Component({
  selector: 'app-root',
  templateUrl: './classes.component.html',
  styleUrls: ['./classes.component.css']
})
export class ClassesComponent {
    configTest: string;

    constructor(private classService: ClassService, private config: ConfigService) { }
    
    ngOnInit(): void {
        this.configTest = this.config.get('environment') + ", " + this.config.get('region') + ", " + this.config.sessionUserID;
    }
}
