<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Repuestos</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Nuevo registro</h3>
                            </div>
                            <div class="card-body">
                                <Formulario
                                    :accion="'nuevo'"
                                    :repuesto="oRepuesto"
                                ></Formulario>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
import Formulario from "./Formulario.vue";
export default {
    components: {
        Formulario,
    },
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oRepuesto: {
                id: 0,
                codigo: "",
                codificacion: "",
                nombre: "",
                descripcion: "",
                marca: "",
                modelo: "",
                serie: "",
                equipo_id: "",
                precio: "",
                stock_min: "",
                stock_max: "",
                unidad_medida: "",
                dir: "",
                fono: "",
                correo: "",
                almacen: "",
                fabricante: "",
                proveedor: "",
                terciarios: "",
                nombre_contacto: "",
                num_fono: "",
                correo_fabricante: "",
                dir_fabricante: "",
                num_identificacion: "",
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {},
};
</script>

<style></style>
