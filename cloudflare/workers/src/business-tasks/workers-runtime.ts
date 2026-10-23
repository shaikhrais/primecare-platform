import {PostgresCommunicationWorker,type CommunicationRuntimeDependencies} from './runtime.ts';
import {WorkersPrivatePictureRepository,type WorkersImagesBinding} from '../../../../packages/shared/src/communications/workers-pictures.mjs';
import type {PrivatePictureBucket,PrivatePictureOptions} from '../../../../packages/shared/src/communications/pictures.mjs';

export type WorkersCommunicationDependencies=Omit<CommunicationRuntimeDependencies,'pictures'>&{
 /** Trusted native capabilities only. Never accept these from an HTTP body. */
 images:WorkersImagesBinding;
 pictureBucket:PrivatePictureBucket;
 scanPicture:PrivatePictureOptions['scan'];
 maxPicturePixels:number;
 /** The native composition always constructs its bounded private repository. */
 pictures?:never;
};

/** Worker-specific composition; all channel/auth/mail behavior remains inherited.
 * This does not mount a public route, provision providers or grant permissions.
 */
export class WorkersCommunicationWorker<E> extends PostgresCommunicationWorker<E> {
 constructor(dependencies:WorkersCommunicationDependencies){
  if(!dependencies||'pictures' in dependencies)throw Error('Native Workers communication configuration required');
  const {images,pictureBucket,scanPicture,maxPicturePixels,...native}=dependencies;
  const pictures=new WorkersPrivatePictureRepository({images,bucket:pictureBucket,scan:scanPicture,
   maxPixels:maxPicturePixels,maxBytes:native.limits?.maxPictureBytes});
  super({...native,pictures});
 }
}
