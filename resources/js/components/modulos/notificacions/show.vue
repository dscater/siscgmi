<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Notificaciones</h1>
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
                                <h4 class="col-md-12 font-weight-bold text-lg">
                                    {{ oNotificacion.notificacion }}
                                </h4>
                            </div>
                            <div class="card-body">
                                <div
                                    class="row"
                                    v-if="
                                        oNotificacion.tipo == 'GENERACIÓN DE OT'
                                    "
                                >
                                    <div class="col-md-12">
                                        <p>
                                            <strong>Código OT:</strong>
                                            {{
                                                oNotificacion.orden_generada
                                                    .orden.id
                                            }}
                                        </p>
                                        <p>
                                            <strong
                                                >Código de
                                                Mantenimiento:</strong
                                            >
                                            {{
                                                oNotificacion.orden_generada
                                                    .orden.gama.codigo
                                            }}
                                        </p>
                                        <p>
                                            <strong>Descripción:</strong>
                                            {{
                                                oNotificacion.orden_generada
                                                    .orden.gama.descripcion
                                            }}
                                        </p>
                                        <p>
                                            <strong>Programación:</strong>
                                            {{
                                                oNotificacion.orden_generada
                                                    .orden.fecha_programada
                                            }}
                                        </p>
                                        <p>
                                            <strong>Código de Equipo:</strong>
                                            {{
                                                oNotificacion.orden_generada
                                                    .orden.gama.equipo.codigo
                                            }}
                                        </p>
                                        <p class="mb-0">
                                            <strong
                                                >Código de Subunidad:</strong
                                            >
                                            {{
                                                oNotificacion.orden_generada
                                                    .orden.subunidad.codigo
                                            }}
                                        </p>
                                    </div>
                                </div>
                                <div
                                    class="row"
                                    v-if="
                                        oNotificacion.tipo ==
                                        'PEDIDO DE REPUESTO'
                                    "
                                >
                                    <div class="col-md-12">
                                        <p>
                                            <strong>Código Pedido:</strong>
                                            {{
                                                oNotificacion.pedido_repuesto.id
                                            }}
                                        </p>
                                        <p>
                                            <strong>Código OT:</strong>
                                            {{
                                                oNotificacion.pedido_repuesto
                                                    .orden_trabajo.id
                                            }}
                                        </p>
                                        <h4 class="text-md">
                                            LISTA DE REPUESTOS SOLICITADOS
                                        </h4>
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Repuesto</th>
                                                    <th>Cantidad requerida</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr
                                                    v-for="(
                                                        item, index
                                                    ) in oNotificacion
                                                        .pedido_repuesto
                                                        .detalle_pedidos"
                                                >
                                                    <td>{{ index + 1 }}</td>
                                                    <td>
                                                        {{
                                                            item.repuesto
                                                                .full_name
                                                        }}
                                                    </td>
                                                    <td>
                                                        {{
                                                            item.cantidad_requerida
                                                        }}
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div
                                    class="row"
                                    v-if="
                                        oNotificacion.tipo ==
                                        'CAMBIO DE ESTADO OT'
                                    "
                                >
                                    <div class="col-md-12">
                                        <p>
                                            <strong>Código OT:</strong>
                                            {{ oNotificacion.orden_trabajo.id }}
                                        </p>
                                        <p>
                                            <strong>Estado actual:</strong>
                                            {{
                                                oNotificacion.orden_trabajo
                                                    .estado
                                            }}
                                        </p>
                                        <p>
                                            <strong
                                                >Razón de cambio de
                                                estado:</strong
                                            >
                                            {{
                                                oNotificacion.orden_trabajo
                                                    .razon
                                            }}
                                        </p>
                                        <p>
                                            <strong>Comentario:</strong>
                                            {{
                                                oNotificacion.orden_trabajo
                                                    .comentario
                                            }}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    props: ["id"],
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oNotificacionUser: {
                id: 0,
                visto: 0,
                notificacion_id: "",
                notificacion: {
                    id: 0,
                    registro_id: "",
                    tipo: "",
                    notificacion: "",
                },
            },
            oNotificacion: {
                id: 0,
                registro_id: "",
                tipo: "",
                notificacion: "",
            },
            notificacionInterval: null,
        };
    },
    watch: {
        id(newVal) {
            this.loadingWindow = Loading.service({
                fullscreen: this.fullscreenLoading,
            });
            let self = this;
            this.getNotificacion();
            setTimeout(() => {
                self.loadingWindow.close();
            }, 700);
        },
    },
    mounted() {
        let self = this;
        setTimeout(() => {
            self.loadingWindow.close();
        }, 700);
        this.getNotificacion();
    },
    methods: {
        getNotificacion() {
            axios("/admin/notificacions/" + this.id).then((response) => {
                this.oNotificacionUser = response.data.notificacion_user;
                this.oNotificacion = response.data.notificacion;
            });
        },
    },
};
</script>

<style></style>
