declare function resolve<T>(val: Promise<T>): Promise<T>;
declare function resolve(val: any): Promise<any>;
export default resolve;

